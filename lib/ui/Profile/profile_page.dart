import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_labs/data_repository.dart';

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
  void initState() {
    super.initState();
    firstNameController.text = DataRepository.firstName;
    lastNameController.text = DataRepository.lastName;
    phoneController.text = DataRepository.phone;
    emailController.text = DataRepository.email;
  }

  @override
  void dispose(){
    DataRepository.firstName = firstNameController.text;
    DataRepository.lastName = lastNameController.text;
    DataRepository.phone = phoneController.text;
    DataRepository.email = emailController.text;

    DataRepository.saveData();

    super.dispose();
  }

  Future<void> launchLink(String scheme, String value) async {
    Uri url = Uri(scheme: scheme, path: value);
    bool success = false;

    try {
      success = await launchUrl(url);
    } catch (e){
      success = false;
    }

    if(!success){
      showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(scheme + ': URLs are not supported')
      ));
    }
    await launchUrl(url);
  }
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
              ElevatedButton(onPressed: () {launchLink('tel',phoneController.text);}, child: Icon(Icons.phone)),
              ElevatedButton(onPressed: () {launchLink('sms',phoneController.text);}, child: Icon(Icons.sms)),
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
              ElevatedButton(onPressed: () {launchLink('mailto',emailController.text);}, child: Icon(Icons.mail)),
            ],
          ),
        ],
      ),
    );
  }
}
