import json
import boto3
import xml.etree.ElementTree as ET

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
    
    filen = filexml.replace('xmlns="http://www.orienteering.org/datastandard/3.0"','')
    filen = filen.replace('xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"','')
    root = ET.fromstring(filen)
    
    dict = []
    for elem in root.findall('ClassResult'):
        category = elem.find('Class/Name').text
        length = elem.find('Course/Length').text
        climb = elem.find('Course/Climb').text
        event = {"Categoria":category, "Lunghezza":length, "Dislivello":climb}
        dict.append(event)
    
    return {
        'statusCode': 200,
        'body': json.dumps(dict)
    }
