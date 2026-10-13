import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _loginKey = 'login';
  static const String _passwordKey = 'password';

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _prefs = EncryptedSharedPreferences();


  String _imagePath = 'assets/image/questionMark.png';

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSavedLogin());
  }
  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedLogin() async {
    final savedLogin = await _prefs.getString(_loginKey);
    final savedPassword = await _prefs.getString(_passwordKey);

    if (!mounted) return;
    if (savedLogin.isEmpty || savedPassword.isEmpty) return;

    setState(() {
      _loginController.text = savedLogin;
      _passwordController.text = savedPassword;
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Previous credential has been loaded'),
            action: SnackBarAction(
                label: 'undo',
                onPressed: (){
                  setState(() {
                    _loginController.text = '';
                    _passwordController.text = '';
                  });
                })
        )
    );
  }

  Future<void> _onLoginPressed() async {
    final bool? save = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Save login'),
        content: const Text(
          'Would you like to save your login name and password for next time?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('No')
          ),
          TextButton(
            onPressed: ()=> Navigator.of(dialogContext).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (save == true) {
      await _prefs.setString(_loginKey, _loginController.text);
      await _prefs.setString(_passwordKey, _passwordController.text);
      print('Saved!');
    } else {
      await _prefs.clear();
      print('Cleared');
    }
    if(!mounted) return;

    setState(() {
      if(_passwordController.text=='QWERTY123'){
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