#!/bin/bash

bosh interpolate \
  logsearch-config/varsfiles/terraform.yml \
  -l terraform-yaml/state.yml \
  > terraform-secrets/terraform.yml


