import 'dart:convert';

import 'package:app_races/ListRaces.dart';

import './ButtonRace.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState(){
    return _MyAppState();
  }
  
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            title: const Text("Race Results App"), 
            backgroundColor: Color.fromARGB(255, 25, 25, 25),
            centerTitle: true,
          ), 
          body: ListRaces()
    );
  }
}








