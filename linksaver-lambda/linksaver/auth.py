import json
import requests
from requests.exceptions import RequestException

def create_user(event, context):
    user_id = event['request']['userAttributes']['username']
    email = event['request']['userAttributes']['email']
    api_url = "http://localhost:9090/user"
    data = {
        "cognitoId": user_id,
        "email": email
    }
    headers = {
        'Content-Type': 'application/json',
        'X-API-Key': 'api_key'
    }
    
    try:
        response = requests.post(api_url, json=data, headers=headers)
        response.raise_for_status()
        print(response.content)
    except RequestException as e:
        print(f"Error making request to {api_url}: {e}")
    
    return event
