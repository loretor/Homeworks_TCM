import json
import boto3
import xml.etree.ElementTree as ET
#serve per poter convertire le stringhe di date in oggetti datetime
from datetime import datetime

#funzione che riceve due stringhe che sono i due tempi e calcola la differenza tra i due
def getResult(partenza, arrivo):
    p = datetime.fromisoformat(partenza)
    a = datetime.fromisoformat(arrivo)
    risultato = a-p
    return str(risultato)


def lambda_handler(event, context):
    params = event['rawQueryString']
    
    raceid = str(params.split('&')[0]).split("=")[1]
    category = str(params.split('&')[1]).split("=")[1]
    #category = category.replace("%20"," ")
    
    s3 = boto3.client("s3")
    try:
        response = s3.get_object(Bucket = "results-raceid", Key = raceid+".xml")
    except:
        return{
            'statusCode':400,
            'body':json.dumps("Non esistono risultati salvati per questa gara")
        }
    filexml = response['Body'].read().decode("utf-8")
    filen = filexml.replace('xmlns="http://www.orienteering.org/datastandard/3.0"','')
    filen = filen.replace('xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"','')
    root = ET.fromstring(filen)

    classifica = []
        
    for elem in root.findall('ClassResult'):
        if elem.find('Class/Id').text == category:
            for per in elem.findall('PersonResult'):
                    posizione = str(per.find('Result/Position').text)
                    name = str(per.find('Person/Name/Given').text)
                    surname = str(per.find('Person/Name/Family').text)
                    partenza = str(per.find('Result/StartTime').text)
                    arrivo = str(per.find('Result/FinishTime').text)
                    status = str(per.find('Result/Status').text)
                    org = str(per.find('Organisation/Name').text)
                    
                    #se non ha uno status = 'OK' non prendiamo gli split time perchè non ci sono neanche
                    result = per.find('Result')
                    split = []
                        
                    #non tutti hanno completato la corsa, qualora abbiano uno stato diverso da OK ritorno come risultato lo stato della corsa
                    if status == 'OK':
                        risultato = getResult(partenza, arrivo)
                        
                        #estrazione di tutti gli split time e li appendiamo all'array split
                        for splittime in result.findall('SplitTime/Time'):
                            split.append(splittime.text)
                    else:
                        risultato = status

                    person = {"Position": posizione, "Name":name, "Surname":surname, 'Result':risultato, 'Organisation':org, 'Split':split}
                    classifica.append(person)
        file = classifica
        
    return {
        'statusCode': 200,
        'body': json.dumps(file)
    }
