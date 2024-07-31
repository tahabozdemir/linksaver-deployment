import json
import os
import urllib3
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError
from urllib3.exceptions import NewConnectionError, MaxRetryError

def get_instance_public_ip(instance_id):
    ec2 = boto3.client('ec2')
    try:
        response = ec2.describe_instances(InstanceIds=[instance_id])
        public_ip = response['Reservations'][0]['Instances'][0]['PublicIpAddress']
        return public_ip
    except (NoCredentialsError, PartialCredentialsError, ClientError) as e:
        print(f"Failed to get EC2 instance public IP: {e}")
        return None

def create_user(event, context):
    user_id = event['request']['userAttributes']['sub']
    email = event['request']['userAttributes']['email']
    
    # Retrieve the instance ID from the environment variable
    instance_id = os.getenv('EC2_INSTANCE_ID')
    if not instance_id:
        print("EC2_INSTANCE_ID environment variable is not set. Exiting.")
        return event

    # Get the public IP address of the instance
    public_ip = get_instance_public_ip(instance_id)
    if not public_ip:
        print("Could not retrieve EC2 instance public IP. Exiting.")
        return event

    # Construct the API URL using the public IP address
    api_url = f"http://{public_ip}/users"
    
    data = json.dumps({
        "cognitoId": user_id,
        "email": email
    })
    headers = {
        'Content-Type': 'application/json',
        'X-API-Key': 'api-key'
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
