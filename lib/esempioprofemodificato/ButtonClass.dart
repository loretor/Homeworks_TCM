import 'package:flutter/material.dart';

class ButtonClass extends StatelessWidget {
  String category;

  ButtonClass(this.category);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      //once pressed the system navigate to another screen
      onPressed: () {
        //Navigator.push(
        Text("ciao");
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
            category,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13
            ),
          ),
        ],
      )
    );
  }
}
