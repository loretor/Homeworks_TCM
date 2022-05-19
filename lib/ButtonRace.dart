import 'package:flutter/material.dart';
import './main.dart';
import './ListClasses.dart';




class ButtonRace extends StatelessWidget {
  String name;
  String date;
  String id;

  ButtonRace(this.name, this.date, this.id);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      //once pressed the system navigate to another screen
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (
              (context) => ListClasses(id)
            )
          )
        );
      },
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: const Color.fromARGB(255, 49, 35, 65),
        side: const BorderSide(
          color: Color(0xFFBB86FC),
          width: 1.0
        ),
        padding: const EdgeInsets.all(20),
        minimumSize: const Size(200,30),
      ), 
      child: Column(
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 7,
              fontStyle: FontStyle.italic
            ),
          )
        ],
      )
    );
  }
}
