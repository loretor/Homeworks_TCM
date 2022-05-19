import 'dart:convert';
import 'package:app_races/ButtonRunner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const api = 'https://988ygxfl33.execute-api.us-east-1.amazonaws.com';

String categoria = '';
String race = '';

//function that returns the list of the athletes of the category and race specified
Future<List> getRunners() async {
  final response = await http.get(Uri.parse(api+'/results?race_id='+race+'&class='+categoria));

  if (response.statusCode == 200) {
    //get the array of values from api/list_races
    return List.from(jsonDecode(response.body));
  } 
  else {
    throw Exception('Failed to load races');
  }
}

class ListRunners extends StatefulWidget {
  late String race_id;
  late String category;
  
  ListRunners(r, c){
    race_id = r;
    category = c;
    categoria = category;
    race = race_id;
  }

  @override
  State<ListRunners> createState() => _ListRunnersState();
}

class _ListRunnersState extends State<ListRunners> {
  late Future<List> listrunners;

  @override
  void initState(){
    listrunners = getRunners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            title: Text(categoria), 
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
                      future: listrunners,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List runners = snapshot.data!;
                          return ListView.builder(
                          itemCount: runners.length,
                          itemBuilder: ((context, index) => 
                            ButtonRunner(
                              runners[index]['Position'],
                              runners[index]['Name'],
                              runners[index]['Surname'],
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