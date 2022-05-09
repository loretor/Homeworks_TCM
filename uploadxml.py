import boto3
import json
import uuid
#libreria per verificare se il body è in formato xml
import xml.etree.ElementTree as elementTree


#funzione per verificare la corretta formattazione del body della richiesta Http
#se non si riesce a fare il parsing da stringa a file xml allora viene sollevata l'eccezione e la funzione ritorna False
#in caso contrario la funzione ritorna True se il parsing è corretto
def isXml(value):
    try:
        elementTree.fromstring(value)
    except elementTree.ParseError:
        return False
    return True
 
  
def lambda_handler(event, context):
    
    content = event['body']
    stringa = content.encode()
    
    ## controllo del corretto formato del body della richiesta Http
    if(isXml(stringa) == False):
        return {
            'statusCode': 500,
            'body': json.dumps('File non rappresentato in formato XML')
        }
    
    #ricaviamo il race id dall'evento che ha sollevato questa lambda, ovvero l'evento generato dall'API con la politica IAM di accesso consentito
    race_id = event["requestContext"]["authorizer"]["lambda"]["race_id"]


    #content = content.replace('xmlns="http://www.orienteering.org/datastandard/3.0"',"")

    
    s3 = boto3.resource("s3")
    s3.Bucket("results-raceid").put_object(Key = race_id+".xml", Body = content)
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps("File caricato correttamente per la gara: "+race_id)
    }
