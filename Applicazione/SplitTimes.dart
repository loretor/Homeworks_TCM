import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './SplitTab';

const api = 'https://988ygxfl33.execute-api.us-east-1.amazonaws.com';

String race_id = '';
String classe = '';

//function that returns the list of the athletes of the category and race specified
Future<List> getSplits() async {
  final response = await http.get(
      Uri.parse(api + '/splitimes?race_id=' + race_id + '&class=' + classe));

  if (response.statusCode == 200) {
    //get the array of values from api/list_races
    return List.from(jsonDecode(response.body));
  } else {
    List listavuota = [];
    return listavuota;
  }
}

class SplitTimes extends StatefulWidget {
  late String race;
  late String category;

  //costruttore
  SplitTimes(race, category) {
    this.race = race;
    this.category = category;
    race_id = race;
    classe = category;
  }

  @override
  State<SplitTimes> createState() => _SplitTimesState();
}

class _SplitTimesState extends State<SplitTimes> {
  late Future<List> listsplits;

  @override
  void initState() {
    listsplits = getSplits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: AppBar(
          title: Text('splitTimes'),
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
                        future: listsplits,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List parziali = snapshot.data!;
                            return ListView.builder(
                              itemCount: parziali.length,
                              itemBuilder: ((context, index){
                                return SplitTab(
                                  parziali[index]['Position'],
                                  parziali[index]['Name'],
                                  parziali[index]['Surname'],
                                  parziali[index]['Result'],
                                  parziali[index]['Organisation'],
                                  parziali[index]['Split'],
                                  );
                              }),
                              );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator(
                              color: Color(0xFFBB86FC), value: 0.8);
                        })))));
  }
}
