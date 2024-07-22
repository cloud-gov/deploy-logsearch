#!/bin/bash

curl -H 'Content-Type: application/json' -XPUT "${HOST}":9200/_all/_settings -d @<(cat <<JSON
{
  "index.search.slowlog.threshold.query.info": "5s",
  "index.search.slowlog.threshold.fetch.info": "5s"
}
JSON
)
