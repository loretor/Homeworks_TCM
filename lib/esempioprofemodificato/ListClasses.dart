import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ButtonClass.dart';

const api = 'https://988ygxfl33.execute-api.us-east-1.amazonaws.com';
String race = '';

//function that returns the list of classes only when the connection is done
Future<List> getClasses() async {
  final response = await http.get(Uri.parse(api+'/list_classes?id='+race));

  if (response.statusCode == 200) {
    //get the array of values from api/list_races
    return List.from(jsonDecode(response.body));
  } 
  else {
    throw Exception('Failed to load races');
  }
}


class ListClasses extends StatefulWidget {
  late String race_id;
  
  ListClasses(r){
    this.race_id = r;
    race = r;
  }

  @override
  State<ListClasses> createState() => _ListClassesState();
}


class _ListClassesState extends State<ListClasses> {
  late Future<List> listclasses;

  @override
  void initState(){
    listclasses = getClasses();
    //listafissa = listevent as List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            title: const Text("Race Results App"), 
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
                      future: listclasses,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List categorie = snapshot.data!;
                          return ListView.builder(
                          itemCount: categorie.length,
                          itemBuilder: ((context, index) => 
                            ButtonClass(
                              categorie[index]['Categoria']
                            )
                          ),
                        );
                        }
                        else if(snapshot.hasError){
                          return Text('${snapshot.error}');
                        }

                        return CircularProgressIndicator(
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