# 18F cloud.gov ELK deployment

This repo contains the pipeline and [BOSH](https://bosh.io) manifests for deploying cloud.gov [ELK](https://www.elastic.co/videos/introduction-to-the-elk-stack) implementation.

### UAA Setup

To set up the UAA client, add the following to the CF secrets:

```yaml
properties:
  uaa:
    clients:
      kibana_oauth2_client:
        secret: CHANGEME
        scope: scim.userids,cloud_controller.read,openid,oauth.approvals
        authorized-grant-types: refresh_token,authorization_code
        redirect-uri: https://CHANGEME/login
        autoapprove: true
```
