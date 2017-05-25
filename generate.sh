#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

SECRETS=$SCRIPTPATH/secrets.yml
MANIFEST=$SCRIPTPATH/manifest.yml
if [ ! -z "$1" ]; then
  SECRETS=$1
fi
if [ ! -z "$2" ]; then
  ENVIRONENT=$2
fi
if [ ! -z "$3" ]; then
  MANIFEST=$3
fi

spruce merge \
  --prune terraform_outputs \
  $SCRIPTPATH/logsearch-deployment.yml \
  $SCRIPTPATH/logsearch-jobs.yml \
  $ENVIRONMENT \
  $SECRETS \
  > $MANIFEST
