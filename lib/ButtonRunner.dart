import 'package:app_races/ListRunnersClass.dart';
import 'package:flutter/material.dart';



class ButtonRunner extends StatelessWidget {
  String race;
  String name;
  String position;
  String surname;
  String result;
  String organisation;

  ButtonRunner(this.race,this.position, this.name, this.surname, this.result, this.organisation);

  @override
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
                    position+'°',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    name+' '+surname,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  )
                ]
              ), 
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontStyle: FontStyle.italic
                ),
              )
            ]
          ),
          Container(
            alignment: Alignment.centerLeft,

            margin: EdgeInsets.only(left: 10, top: 0),
            child: MaterialButton(
                minWidth: 5,
                height: 10,
                color: Color(0xFF121212),
                child: Text(
                    organisation,
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFFBB86FC),
                      decoration: TextDecoration.underline
                    ),
                ),
                onPressed:(){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (
                        (context) => ListRunnersClass(race, organisation)
                      )
                    )
                  );
                },
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


