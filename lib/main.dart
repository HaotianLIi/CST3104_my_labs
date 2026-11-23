import 'package:flutter/material.dart';
import 'package:my_labs/ui/list/list_page.dart';
import 'package:my_labs/ui/login/login_screen.dart';


// The app starts here.
void main() {
  runApp(const MyApp());
}

// MyApp is the outer shell of the app.
// Its only job is to open the login screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is needed for the AlertDialog and the SnackBar to work.
    return const MaterialApp(
      home: ShoppingListPage(),
    );
  }
}