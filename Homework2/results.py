import boto3
from boto3.dynamodb.conditions import Key
import json
import xmltodict

def lambda_handler(event, context):
    # TODO implement
    content = event['body']
    
    s3 = boto3.client("s3")
    
    ## connessione al DynamoDB e ricerca delle tuple che soddisfino condizione key = content
    db = boto3.resource("dynamodb")
    table = db.Table('TabEvents')
    lista = table.query(KeyConditionExpression=Key('Event').eq(content))
    
    if(len(lista['Items']) == 0):
        return{
            'statusCode': 500,
            'body': json.dumps("Non esistono ancora file salvati per l'Evento "+content)
        }
        
    ## estrazione dei file con id univoco contenuti all'interno del bucket S3, il contenuto viene poi inserito nel dizionario data_dict
    data_dict = []
    
    for elem in lista['Items']:
        id = elem['FileId']
        response = s3.get_object(Bucket = "resultxml", Key = id+".xml")
        
        #in caso si può ritornare il file xml tramite return{'body': json.dumps(response['Body'].read().decode("utf-8"))}
        filexml = response['Body'].read().decode("utf-8")
        dict = xmltodict.parse(filexml)
        data_dict.append(dict)

    #si ritorna infine il dizionario (che contiene tutti i file associati a quell'evento trasformato in formato json
    return {
        'statusCode': 200,
        #parsing da xml a json
        'body': json.dumps(data_dict, indent=2)
    }
