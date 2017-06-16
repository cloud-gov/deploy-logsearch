#!/usr/bin/env python

import os
import sys
import urllib
import requests

if __name__ == "__main__":
    session = requests.Session()

    logs = session.get('https://logs.{}'.format(os.environ['CF_SYSTEM_DOMAIN']))
    print(logs.url, logs.status_code)
    logs.raise_for_status()

    login = session.post(
        'https://login.{}/login.do'.format(os.environ['CF_SYSTEM_DOMAIN']),
        data={
            'username': os.environ['CF_USERNAME'],
            'password': os.environ['CF_PASSWORD'],
            'X-Uaa-Csrf': logs.cookies['X-Uaa-Csrf'],
        }
    )
    print(login.url, login.status_code)
    login.raise_for_status()
    query = urllib.parse.parse_qs(urllib.parse.urlparse(login.url).query)
    if 'error' in query:
        sys.exit(1)
