#!/bin/bash

set -eux

file_size=0
file_count=0
now=$(date -u)

tempfile=$(mktemp)

log_count=$(curl -s "${ES_HOST}:${ES_PORT:-9200}/${INDEX_PATTERN}/_search?size=0" -d @<(cat <<EOF
{
  "query": {
    "range": {
      "@timestamp": {
        "gt": "now-20m",
        "lte": "now-10m"
      }
    }
  }
}
EOF
) | jq -r '.hits.total')

cat <<EOF > ${tempfile}
logsearch_backup_log_count {environment="${ENVIRONMENT}"} ${log_count}
logsearch_backup_timestamp {environment="${ENVIRONMENT}"} $(date --date "${now}" +%s)
EOF

if [ -n "${BUCKET_NAME:-}" ]; then
  for idx in {10..19}; do
    prefix=$(date -u +%Y/%m/%d/%H/%M --date "${now} -${idx} min")
    for obj_size in $(aws s3 ls "s3://${BUCKET_NAME}/${prefix}/" | awk '{print $3}'); do
      file_size=$((file_size + obj_size))
      file_count=$((file_count + 1))
    done
  done

  cat <<EOF >> ${tempfile}
logsearch_backup_file_size {environment="${ENVIRONMENT}"} ${file_size}
logsearch_backup_file_count {environment="${ENVIRONMENT}"} ${file_count}
EOF
fi

curl --data-binary @${tempfile} "${GATEWAY_HOST}:${GATEWAY_PORT:-9091}/metrics/job/logsearch_backup/instance/${ENVIRONMENT}"
