import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref{
  static Future storeToken(token)async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}