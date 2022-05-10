import boto3
import json
import uuid
#libreria per poter creare id univoci per ogni nuovo file che viene inserito
import hashlib
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
    # TODO implement
    content = event['body']
    stringa = content.encode()
    
    
    ## controllo del corretto formato del body della richiesta Http
    if(isXml(stringa) == False):
        return {
            'statusCode': 500,
            'body': json.dumps('File non rappresentato in formato XML')
        }
    
    
    ## ricerca del nome dell'evento tramite anche XPath
    #se la root dell'albero è già Event
    root = elementTree.fromstring(stringa)
    EventName = root.find('.//Name')
    
    #qualora la root non sia Event devo cercarla con XPath, osservando però la presenza degli attributi xmlns = {http://www.orienteering.org/datastandard/3.0}
    if(root.tag != "Event"):
        #usiamo XPath per trovare tutti i nodi dell'albero XML, a qualsiasi profondità che siano Event/Name rispettando gli xmlns
        Event = root.find('{http://www.orienteering.org/datastandard/3.0}Event')
        
        if(Event == None):
            EventName = None
        else:
            EventName = Event.find('{http://www.orienteering.org/datastandard/3.0}Name')

    ## creazione dell'id univoco utilizzando l'algoritmo SHA256
    id = hashlib.sha256(stringa).hexdigest()
    
    db = boto3.client('dynamodb')
    
    #qualora la ricerca con XPath non produca risultati
    if(EventName == None):
        db.put_item(TableName = 'TabEvents', Item = { "Event": {"S": "NotEvent"}, "FileId": {"S": id}})
    else:
        db.put_item(TableName = 'TabEvents', Item = { "Event": {"S": EventName.text}, "FileId": {"S": id}})
    
    
    s3 = boto3.resource("s3")
    s3.Bucket("resultxml").put_object(Key = id+".xml", Body = content)
    
    return {
        'statusCode': 200,
        'body': json.dumps("File caricato correttamente")
    }
    
