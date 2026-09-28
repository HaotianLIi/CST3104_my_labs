import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: 'Login'),),
          TextField(obscureText:true,
                    decoration: InputDecoration(labelText: 'Password'),),
          ElevatedButton(
              onPressed: () { print('pressed');},
              child: Text('Login')),
        ],
      )
    ),
  ));
}

