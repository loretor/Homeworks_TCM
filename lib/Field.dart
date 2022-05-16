import 'package:flutter/material.dart';
import 'Button.dart';

class Field extends StatefulWidget {
  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(padding: EdgeInsets.all(32), children: [
      buildname(),
      const SizedBox(height: 24),
      Button("Sumbit"),
    ]));
  }

  Widget buildname() {
    return TextField(
        controller: namecontroller,
        decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Color(0xFFBB86FC),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF121212),
                width: 1
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFBB86FC),
                width: 1
              )
            ),
            suffixIcon: IconButton(
              onPressed: () => namecontroller.clear(), 
              icon: Icon(Icons.close),
              color: Color(0xFFBB86FC),
            ),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255)
        )    
    );
  }
}
