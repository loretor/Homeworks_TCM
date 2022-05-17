import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ButtonRace.dart';

const api = 'https://988ygxfl33.execute-api.us-east-1.amazonaws.com';

//function that returns the list of events only when the connection is done
Future<List> connectForRaces() async {
  final response = await http.get(Uri.parse(api+'/list_races'));

  if (response.statusCode == 200) {
    //get the array of values from api/list_races
    return Map<String,dynamic>.from(jsonDecode(response.body))['ListEvent']['Event'];
  } 
  else {
    throw Exception('Failed to load races');
  }
}


class ListRaces extends StatefulWidget {
  const ListRaces({Key? key}) : super(key: key);

  @override
  State<ListRaces> createState() => _ListRaces();
}

class _ListRaces extends State<ListRaces> {
  late Future<List> listevent;
  //List listafissa ;

  @override
  void initState(){
    listevent = connectForRaces();
    //listafissa = listevent as List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFF121212),
          body: Center(
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              //width: double.infinity,
              child: FutureBuilder<List>(
                    future: listevent,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        List eventi = snapshot.data!;
                        return ListView.builder(
                        itemCount: eventi.length,
                        itemBuilder: ((context, index) => 
                          ButtonRace(
                            eventi[index]['race_name'] as String,
                            eventi[index]['race_date'] as String,
                            eventi[index]['race_id'] as String
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
          );
    }
}