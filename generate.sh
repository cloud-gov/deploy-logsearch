#!/bin/sh

set -e -x

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )

SECRETS=$SCRIPTPATH/secrets.yml
MANIFEST=$SCRIPTPATH/manifest.yml
if [ ! -z "$1" ]; then
  SECRETS=$1
fi
if [ ! -z "$2" ]; then
  MANIFEST=$2
fi

spruce merge \
  $SCRIPTPATH/logsearch-deployment.yml \
  $SCRIPTPATH/logsearch-jobs.yml \
  $SCRIPTPATH/logsearch-hardening.yml \
  $SCRIPTPATH/logsearch-infrastructure-aws.yml \
  $SECRETS \
  > $MANIFEST
