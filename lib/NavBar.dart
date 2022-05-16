
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("loretor"), 
            accountEmail: Text("lorenzo@gmail.com"),
            decoration: BoxDecoration(
              color: Color(0xFFBB86FC)
            ),
          ),
          ListTile(
            title: Text('Select Race'),
            onTap: () => print('selezione'),
            textColor: Color.fromARGB(255, 255, 255, 255)
          ),
          ListTile(
            title: Text('ciao 2'),
            onTap: () => print('selezione'),
            textColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      backgroundColor: Color(0xFF242424),
    );
  }
}