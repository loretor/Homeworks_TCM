import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String text;

  Button(this.text);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => print("ciao"), 
      child: Text(text),
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Color.fromARGB(255, 49, 35, 65),
        side: BorderSide(
          color: Color(0xFFBB86FC),
          width: 1.0
        ),
        padding: EdgeInsets.all(20),
        minimumSize: Size(300,30),
      )
    );
  }
}
