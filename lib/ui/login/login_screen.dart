import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  String _imagePath = 'assets/image/questionMark.png';

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    setState(() {
      if (_passwordController.text == 'QWERTY123') {
        _imagePath = 'assets/image/lightBall.png';
      } else {
        _imagePath = 'assets/image/Stop.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: const Text('Login'),
            ),
            Image.asset(_imagePath, width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}