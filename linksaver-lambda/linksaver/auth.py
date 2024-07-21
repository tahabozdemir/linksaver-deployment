import json
import urllib3
from urllib3.exceptions import NewConnectionError, MaxRetryError

def create_user(event, context):
    user_id = event['request']['userAttributes']['username']
    email = event['request']['userAttributes']['email']
    api_url = "docker.for.mac.localhost:9090/user"
    data = json.dumps({
        "cognitoId": user_id,
        "email": email
    })
    headers = {
        'Content-Type': 'application/json',
        'X-API-Key': 'api_key'
    }
    http = urllib3.PoolManager()

    try:
        response = http.request('POST',
                                api_url,
                                body=data,
                                headers=headers,
                                retries=False)
        print(f"Response status: {response.status}")
        print(f"Response data: {response.data.decode('utf-8')}")
    except NewConnectionError as e:
        print(f"Failed to establish a new connection: {e}")
    except MaxRetryError as e:
        print(f"Max retries exceeded: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

    return event
