import 'package:flutter/material.dart';

void main() {
  String imagePath = 'assets/image/questionMark.png';
  final passwordController = TextEditingController();

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Flutter Demo Home Page')),
      body: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column (
              children: [
                TextField(decoration: InputDecoration(labelText: 'Login'),),
                TextField(obscureText:true,
                          controller: passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(passwordController.text == 'QWERTY123') {
                        imagePath = 'assets/image/lightBall.png';
                      } else {
                        imagePath = 'assets/image/Stop.png';
                      }
                    });
                  },
                  child: Text('Login'),
                ),
                Image.asset(imagePath, width: 300, height: 300,)
              ]
            )
          );
        }
      )
  )));
}

