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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Text('Welcome Back ' + widget.loginName),

          TextField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
          ),

          TextField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),

          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.phone)),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.sms)),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email address'),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Icon(Icons.mail)),
            ],
          ),
        ],
      ),
    );
  }
}
