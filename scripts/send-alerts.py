import boto3

def publish_alert(message,subject="AWS Infra Alert"):
    sns=boto3.client('sns')
    topic_arn="arn:aws:sns:us-east-1:846229150353:Monitoring_team"

    response=sns.publish(
        TopicArn=topic_arn,
        Message=message,
        Subject=subject
    )
    print(f"Alert Published:",response['MessageId'])
if __name__=="_main_":
    publish_alert("High CPU alert on EC2.")