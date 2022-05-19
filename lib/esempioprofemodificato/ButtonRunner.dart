import 'package:flutter/material.dart';



class ButtonRunner extends StatelessWidget {
  String name;
  String position;
  String surname;
  String result;

  ButtonRunner(this.position, this.name, this.surname, this.result);

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
                    position+'.',
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
          Divider(
            color: Color(0xFFBB86FC),
          )
        ],
      )
    );
  }
}


