# Lamdafuction 

Python Code

```

import boto3
from datetime import datetime, timedelta

def lambda_handler(event, context):
    # Initialize AWS clients
    ec2 = boto3.client('ec2')
    sns = boto3.client('sns')
    
    # Get all volumes
    response = ec2.describe_volumes()
    
    # Get current date
    current_date = datetime.now()
    
    # Iterate over volumes
    for volume in response['Volumes']:
        volume_id = volume['VolumeId']
        create_time = volume['CreateTime']
        creator_name = volume.get('Tags', [{'Key': 'Creator', 'Value': 'Unknown'}])[0]['Value']
        
        # Check if volume is unused (not attached to any instance)
        if 'Attachments' not in volume:
            # Calculate time difference between creation time and current time
            time_difference = current_date - create_time.replace(tzinfo=None)
            # If volume is older than 7 days, consider it as unused
            if time_difference.days > 7:
                # Send notification
                sns.publish(
                    TopicArn='YOUR_SNS_TOPIC_ARN',
                    Subject=f"Unused Volume ({volume_id}) Detected",
                    Message=f"Unused volume ({volume_id}) created by {creator_name} detected. Please review and remove if necessary."
                )



```
