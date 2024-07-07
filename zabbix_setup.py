import os
import requests
from dotenv import load_dotenv

load_dotenv()

ZABBIX_URL = 'https://localhost/api_jsonrpc.php'
ZABBIX_USER = 'Admin'
ZABBIX_PASSWORD = os.getenv('ZABBIX_PASSWORD', 'zabbix')

headers = {'Content-Type': 'application/json'}

def get_auth_token():
    data = {
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "user": ZABBIX_USER,
            "password": ZABBIX_PASSWORD
        },
        "id": 1
    }
    response = requests.post(ZABBIX_URL, json=data, headers=headers)
    return response.json()['result']

def create_discovery_rule(auth_token):
    data = {
        "jsonrpc": "2.0",
        "method": "discoveryrule.create",
        "params": {
            "name": "Network Discovery",
            "iprange": "192.168.1.0/24",
            "delay": "3600s",
            "status": 0,
            "dchecks": [
                {
                    "type": 9,
                    "key_": "system.uname",
                    "ports": "10050",
                    "uniq": 0
                }
            ]
        },
        "auth": auth_token,
        "id": 2
    }
    response = requests.post(ZABBIX_URL, json=data, headers=headers)
    print(response.json())

def main():
    auth_token = get_auth_token()
    create_discovery_rule(auth_token)

if __name__ == '__main__':
    main()