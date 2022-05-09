import json
import hashlib
import boto3
import xmltodict
import xml.etree.ElementTree as ET

def lambda_handler(event, context):
    # TODO implement
    params = event['rawQueryString']
    
    race_name = (params.split('&')[0]).split("=")[1]
    race_date = (params.split('&')[1]).split("=")[1]
    email = (params.split('&')[2]).split("=")[1]
    
    string_token = (race_name+race_date+email).encode('utf-8')
    string_raceid = (race_name+race_date).encode('utf-8')
    
    token = hashlib.sha256(string_token).hexdigest()
    race_id = hashlib.sha256(string_raceid).hexdigest()
    
    #connessione al DynamoDb
    db = boto3.client('dynamodb')
    db.put_item(TableName = 'Token-RaceID', Item = { "Token": {"S": token}, "RaceID": {"S": race_id}})
    
    #aggiornamento della ListEvent dato che abbiamo creato una nuova gara
    s3 = boto3.client("s3")
    response = s3.get_object(Bucket = "results-raceid", Key = "ListEvent.xml")
    filexml = response['Body'].read().decode("utf-8")
    root = ET.fromstring(filexml)
    
    data = ET.Element('Event')
    item1 = ET.SubElement(data, 'race_name')
    item2 = ET.SubElement(data, 'race_date')
    item3 = ET.SubElement(data, 'race_id')
    item1.text = str(race_name)
    item2.text = str(race_date)
    item3.text = str(race_id)
        
    #vediamo se non è già presente nella lista di eventi una gara con questo id
    trovato = False
    for elem in root.findall('.//race_id'):
        if elem.text == race_id:
            trovato = True
    
    if trovato == False:
        root.append(data)
    xml_str = ET.tostring(root, encoding='unicode')
    
    s3 = boto3.resource("s3")
    s3.Bucket("results-raceid").put_object(Key = "ListEvent.xml", Body = xml_str)
    
    
    return {
        'statusCode': 200,
        'body': json.dumps("Token per autorizzazione: "+token+" Race ID: "+race_id)
    }
    
