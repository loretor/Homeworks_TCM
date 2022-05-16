import 'package:flutter/material.dart';
import './Button.dart';
import 'NavBar.dart';
import 'Options.dart';
import 'Field.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF121212),
            appBar: AppBar(
              title: const Text("Race Results App"), 
              backgroundColor: Color.fromARGB(255, 25, 25, 25),
              centerTitle: true,
            ),
          drawer: NavBar(),  
          body: Field()
      )
    );
  }
}

