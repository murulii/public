# Lamdafuction 

Python Code

```

import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        ec2 = boto3.client('ec2')
        sns = boto3.client('sns')

        # Get all volumes
        volumes = ec2.describe_volumes()['Volumes']

        # Check for unattached volumes
        unattached_volumes_info = []
        for volume in volumes:
            if not volume['Attachments']:
                volume_info = {
                    'VolumeId': volume['VolumeId'],
                    'Name': volume.get('Tags', [{}])[0].get('Value', 'N/A'),
                    'Region': context.invoked_function_arn.split(":")[3],
                    'CreationDate': str(volume['CreateTime'])
                }
                unattached_volumes_info.append(volume_info)

        # Log unattached volumes
        if unattached_volumes_info:
            logger.info(f"Unattached volumes found: {', '.join([v['VolumeId'] for v in unattached_volumes_info])}")

            # Send notification if unattached volumes are found
            message = f"Unattached volumes found:\n"
            for volume_info in unattached_volumes_info:
                message += f"VolumeId: {volume_info['VolumeId']}, Name: {volume_info['Name']}, Region: {volume_info['Region']}, CreationDate: {volume_info['CreationDate']}\n"
            
            sns.publish(TopicArn='add_ur_url_sns', Message=message, Subject='Unattached Volumes')
        else:
            logger.info("No unattached volumes found.")

    except Exception as e:
        logger.error(f"Error: {str(e)}")

    return "Function execution completed"

```
