import 'package:shared_preferences/shared_preferences.dart';

class TokenKeeper {
  static String? _accessToken;

  static String? get accessToken => _accessToken;

  static Future<void> setTokens(String accessToken) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('access_token', accessToken);

    _accessToken = accessToken;
  }

  static Future<void> getTokens() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access_token');
  }

  static Future<void> clear() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _accessToken = null;
  }
}
