import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String loginName;

  ProfilePage(this.loginName);

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Text('Welcome Back ' + widget.loginName),
    );
  }
}