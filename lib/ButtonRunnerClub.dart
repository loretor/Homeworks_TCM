import 'package:app_races/ListRunnersClass.dart';
import 'package:flutter/material.dart';



class ButtonRunnerClub extends StatelessWidget {
  String name;
  String position;
  String surname;
  String category;
  String result;

  ButtonRunnerClub(this.position, this.name, this.surname, this.category, this.result);

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
                    category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  ),
                  SizedBox(width: 10),
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
                    result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color.fromARGB(255, 255, 255, 255)
                    ),
                  )
                ]
              ),
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
          Divider(
            color: Color(0xFFBB86FC),
          )
        ],
      )
    );
  }
}


