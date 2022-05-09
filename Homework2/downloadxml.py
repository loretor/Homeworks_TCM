import json
import boto3

def lambda_handler(event, context):
    # TODO implement
    params = event['rawQueryString']

    race_id = params.split("=")[1]
    
    s3 = boto3.client("s3")
    try:
        response = s3.get_object(Bucket = "results-raceid", Key = race_id+".xml")
    except:
        return{
            'statusCode':400,
            'body':json.dumps("Non esistono risultati salvati per questa gara")
        }
    
    filexml = response['Body'].read().decode("utf-8")
    
    return {
        'statusCode': 200,
        'body': json.dumps(filexml)
    }
