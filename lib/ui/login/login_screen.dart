import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:my_labs/data_repository.dart';
import 'package:my_labs/ui/Profile/profile_page.dart';

const String loginKey = 'login';
const String passwordKey = 'password';

const String correctPassword = 'QWERTY123';

const String questionImage = 'assets/image/questionMark.png';
const String correctImage = 'assets/image/lightBall.png';
const String wrongImage = 'assets/image/Stop.png';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Read and change the text inside the two text fields.
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Help saves data on the phone (encrypted), so it is still there next time.
  final EncryptedSharedPreferences storage = EncryptedSharedPreferences();

  String currentImage = questionImage;

  // initState runs once, when the screen is first created.
  @override
  void initState() {
    super.initState();
    loadSavedLogin();
    DataRepository.loadData();
  }

  // dispose runs once, when the screen is closed.
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Load the login and password saved last time (if there are any).
  Future<void> loadSavedLogin() async {
    String savedLogin = await storage.getString(loginKey);
    String savedPassword = await storage.getString(passwordKey);

    if (!mounted) return;

    if (savedLogin.isEmpty || savedPassword.isEmpty) return;

    loginController.text = savedLogin;
    passwordController.text = savedPassword;

    showLoadedMessage();
  }

  // Show a message at the bottom of the screen, with an Undo button.
  void showLoadedMessage() {
    SnackBar message = SnackBar(
      content: const Text('Previous login name and password have been loaded'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: clearTextFields,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(message);
  }

  void clearTextFields() {
    loginController.text = '';
    passwordController.text = '';
  }

  // When the Login button is pressed
  Future<void> onLoginPressed() async {
    bool? userSaidYes = await askToSaveLogin();

    if (userSaidYes == true) {
      await saveLogin();
    } else {
      await deleteSavedLogin();
    }

    // Stop if the screen was closed while we were waiting.
    if (!mounted) return;

    checkPassword();
  }

  Future<bool?> askToSaveLogin() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // tapping outside does not close it
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Save login?'),
          content: const Text(
              'Would you like to save your login name and password for next time?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false); // close and answer "No"
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true); // close and answer "Yes"
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // Save what the user typed, so it loads next time.
  Future<void> saveLogin() async {
    await storage.setString(loginKey, loginController.text);
    await storage.setString(passwordKey, passwordController.text);
  }

  Future<void> deleteSavedLogin() async {
    await storage.clear();
  }

  void checkPassword() {
      if (passwordController.text == correctPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome Back ${loginController.text}')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(loginController.text)),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true, // show dots instead of the password
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: onLoginPressed,
              child: const Text('Login'),
            ),
            Image.asset(currentImage, width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}