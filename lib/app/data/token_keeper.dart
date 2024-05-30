import 'package:shared_preferences/shared_preferences.dart';

class TokenKeeper {
  static String? _accessToken;
  static String? _name;
  static String? _email;

  static String? get accessToken => _accessToken;
  static String? get name => _name;
  static String? get email => _email;

  static Future<void> setTokens(
      String accessToken, String name, String email) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('access_token', accessToken);
    await sharedPreferences.setString('name', name);
    await sharedPreferences.setString('email', email);

    _accessToken = accessToken;
    _name = name;
    _email = email;
  }

  static Future<void> getTokens() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access_token');
    _name = sharedPreferences.getString('name');
    _email = sharedPreferences.getString('email');
  }

  static Future<void> clear() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _accessToken = null;
    _name = null;
    _email = null;
  }

  // static bool get isLoggedIn {
  //   return _accessToken != null;
  // }
}
