import 'package:app_races/ButtonRunnerClub.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const api = 'https://988ygxfl33.execute-api.us-east-1.amazonaws.com';

String racename ='';
String clubname = '';

//function that returns the list of the athletes of the race of a specific club
Future<List> getRunnersClub() async {
  final response = await http.get(Uri.parse(api+'/results?race_id='+racename+'&organisation='+clubname));

  if (response.statusCode == 200) {
    //get the array of values from api/list_races
    return List.from(jsonDecode(response.body));
  } 
  else {
    throw Exception('Failed to load races');
  }
}

class ListRunnersClass extends StatefulWidget {
  late String race;
  late String club;

  ListRunnersClass(r, c){
    race = r;
    club = c;
    clubname = club;
    racename = race;
  }

  @override
  State<ListRunnersClass> createState() => _ListRunnersClassState();
}

class _ListRunnersClassState extends State<ListRunnersClass> {
  late Future<List> listrunnersclub;

  @override
  void initState(){
    listrunnersclub = getRunnersClub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            title: Text(clubname), 
            backgroundColor: Color.fromARGB(255, 25, 25, 25),
            centerTitle: true,
          ), 
          body: Scaffold(
            backgroundColor: Color(0xFF121212),
            body: Center(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                //width: double.infinity,
                child: FutureBuilder<List>(
                      future: listrunnersclub,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List runners = snapshot.data!;
                          return ListView.builder(
                          itemCount: runners.length,
                          itemBuilder: ((context, index) => 
                            ButtonRunnerClub(
                              runners[index]['Position'],
                              runners[index]['Name'],
                              runners[index]['Surname'],
                              runners[index]['Category'],
                              runners[index]['Result']
                            )
                          ),
                        );
                        }
                        else if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator(
                          color: Color(0xFFBB86FC),
                          value: 0.8
                        );
                      }
                  )
                )
              )
          )
    );
  }
}