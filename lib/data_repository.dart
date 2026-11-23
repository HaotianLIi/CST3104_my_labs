import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String firstName = '';
  static String lastName = '';
  static String phone = '';
  static String email = '';

  static EncryptedSharedPreferences storage = EncryptedSharedPreferences();

  static Future<void> loadData() async {
    firstName = await storage.getString('firstName');
    lastName = await storage.getString('lastName');
    phone = await storage.getString('phone');
    email = await storage.getString('email');
  }

  static Future<void> saveData() async {
    await storage.setString('firstName', firstName);
    await storage.setString('lastName', lastName);
    await storage.setString('phone', phone);
    await storage.setString('email', email);
  }
}