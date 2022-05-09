import json
import uuid
import boto3
from boto3.dynamodb.conditions import Key

def lambda_handler(event, context):
    
    token = event['headers']['authorization']
    
    ## connessione al DynamoDB e ricerca della tupla con token = authorization
    db = boto3.resource("dynamodb")
    table = db.Table('Token-RaceID')
    lista = table.query(KeyConditionExpression=Key('Token').eq(token))
    
    if len(lista['Items']) == 0:
        response = {
            "principalId": f"{uuid.uuid4().hex}",
            "policyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                    {
                        "Action": "execute-api:Invoke",
                        "Effect": "Deny",
                        "Resource": "arn:aws:execute-api:us-east-1:002067127418:988ygxfl33/*/*"
                    }
                ]
            }
        }
        return response
    else:
        response = {
            "principalId": f"{uuid.uuid4().hex}",
            "policyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                    {
                        "Action": "execute-api:Invoke",
                        "Effect": "Allow",
                        "Resource": "arn:aws:execute-api:us-east-1:002067127418:988ygxfl33/*/*"
                    }
                ]
            },
            "context": {
                "race_id": lista['Items'][0]['RaceID']
            }
        }
        return response
        
