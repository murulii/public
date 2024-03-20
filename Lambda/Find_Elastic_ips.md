```

import boto3
import datetime

def lambda_handler(event, context):
    # Initialize AWS clients
    ec2_client = boto3.client('ec2')
    sns_client = boto3.client('sns')
    
    # Get all Elastic IPs
    response = ec2_client.describe_addresses()
    elastic_ips = response['Addresses']
    
    # Find unused Elastic IPs
    unused_ips = []
    for ip in elastic_ips:
        if 'InstanceId' not in ip:
            unused_ips.append(ip)
    
    # Collect information about unused Elastic IPs
    info_message = ""
    for ip in unused_ips:
        region = ip['Region']
        public_ip = ip['PublicIp']
        name = ""
        if 'Tags' in ip:
            for tag in ip['Tags']:
                if tag['Key'] == 'Name':
                    name = tag['Value']
        creation_time = ip['AllocationTime']
        creation_time = creation_time.strftime("%Y-%m-%d %H:%M:%S")
        
        info_message += f"Region: {region}, Public IP: {public_ip}, Name: {name}, Creation Time: {creation_time}\n"
    
    # Send notification if there are unused IPs
    if info_message:
        sns_topic_arn = 'YOUR_SNS_TOPIC_ARN'
        message = "Unused Elastic IPs found:\n"
        message += info_message
        
        sns_client.publish(TopicArn=sns_topic_arn, Message=message, Subject="Unused Elastic IPs")
    else:
        print("No unused Elastic IPs found.")

    return {
        'statusCode': 200,
        'body': "Lambda function executed successfully"
    }
```
