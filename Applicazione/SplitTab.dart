import './SplitTimes.dart';
import 'package:flutter/material.dart';


class SplitTab extends StatelessWidget {
  String position;
  String name;
  String surname;
  String result;
  String organization;
  List<dynamic> splits;
  String stringa_splits='';

  SplitTab(this.position, this.name, this.surname, this.result, this.organization, this.splits){
      splits.forEach((item) {
        String value = '';
          if (double.parse(item) < 60.00){
            stringa_splits+= '0:'+item+'  ';
          }      
          else{
            double min = (double.parse(item)/60);
            int decimal = min.toInt();
            value += decimal.toStringAsFixed(0);
            int sec = int.parse(item) - decimal *60;
            String seco = sec.toStringAsFixed(0);
            if (seco.length == 1){
              value += ":0"+seco;
            }
            else{
              value += ":"+seco;
            }           
            stringa_splits+= value + '  ';
          }
        }
      );
  }

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Row(
                  children: [
                    Text(
                      position + '°',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 9,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    SizedBox(width: 5),
                    Text(
                      name + ' ' + surname + '  ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 6, color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ]
                ),
                SizedBox(width: 50),
                Row(
                  children:[
                    Text(
                      result + '  ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 7,
                          color: Color(0xFF33691E),
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'splits:',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 7,
                        color: Color(0xFFBF360C),
                        fontStyle: FontStyle.italic),
                      )
                    ]
                ),
                SizedBox(width: 5),
                  Text(
                    stringa_splits,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 7,
                        color: Color.fromARGB(255, 255, 255, 255)),
                )
              ]
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 0),
              child: Column(
                children:[
                  Row(children: [
                    Text(
                      organization,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 5,
                          color: Color(0xFFBB86FC)),
                    ), 
                  ]),
                ]
              ),
            ),

            Divider(
              color: Color(0xFFBB86FC),
            )
        ],
      )
    );
  }
}
