import 'package:flutter/cupertino.dart';

import 'Button.dart';

class Options extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button("Register Race"),
                    SizedBox(height: 20),
                    Button("View Results"),
                    SizedBox(height: 20),
                    Button("Change")
                  ]   
                ),
                width: double.infinity,
              )   
        );
  }
  
}