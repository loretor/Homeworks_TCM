import json
import xmltodict
import boto3

def lambda_handler(event, context):
    
    s3 = boto3.client("s3")
    response = s3.get_object(Bucket = "results-raceid", Key = "ListEvent.xml")
    filexml = response['Body'].read().decode("utf-8")
    dict = xmltodict.parse(filexml)
    
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps(dict, indent=2)
    }
