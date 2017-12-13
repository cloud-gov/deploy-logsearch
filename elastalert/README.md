# 18F cloud.gov elastalert deployment
bosh manifest to deploy and configure cloud.gov elastalert on logsearch deployment

# Reviewing cloud.gov alerts (elastalert)
This document contains notes for reviewing each type of alert fired in PagerDuty. It is not meant to be an exhaustive playbook, but to give initial guidance for how to configure and triage each type.

## CDN Broker failed to renew
### Source data:
https://github.com/18F/cf-cdn-service-broker/blob/master/models/models.go
### Rule body:
https://github.com/18F/cg-deploy-logsearch/blob/master/elastalert/logsearch-elastalert.yml
### Guidance:
A LetsEncrypt certificate managed by the CDN Broker for an application was unable to be renewed. Review logs for the relevant service in cloudfoundry and reach out to the appropriate customer to determine acme challenge status, etc.

## ClamAV alert on host
### Source data:
https://github.com/18F/cg-clamav-boshrelease/blob/master/jobs/clamav/templates/conf/clamd.conf.erb
### Rule body:
https://github.com/18F/cg-deploy-logsearch/blob/master/elastalert/logsearch-platform-elastalert.yml
### Guidance:
Review the indicated instance, file location, and signature detected. AV testing should be performed with “Eicar-Test-Signature”.

If you cannot identify the behavior as known testing follow the security incident response guide.

## Snort alert on host
### Source data:
https://github.com/18F/cg-snort-boshrelease/blob/master/ci/config/snort-conf/snort.conf
### Rule body:
https://github.com/18F/cg-deploy-logsearch/blob/master/elastalert/logsearch-platform-elastalert.yml
### Guidance:
Review the indicated instance, snort ID, and the contents of the snort rule which fired. Review the relevent snort log (https://cloud.gov/docs/ops/runbook/troubleshooting-snort/). Review relevant network/http logs if available for additional context. 

If you cannot positively confirm the alert to be a false positive or true positive/unaffected in the case of vulnerability scanning follow the security incident response guide.

## [TEMPLATE AlertName]
### Source data:
[link to: prometheus exporter, script for push gateway, or log file]
### Rule body:
[link to rule body in github]
### Guidance:
- [What does this alert typically mean]
- [What are common causes]
- [How might you remediate these causes]
