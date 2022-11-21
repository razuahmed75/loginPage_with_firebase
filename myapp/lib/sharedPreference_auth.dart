import 'package:shared_preferences/shared_preferences.dart';

class SaveUserAuth {
  static const String authTokenKey = "token";
  static SharedPreferences? _preferences;
  static String? auth;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setCredential(String authTokenValue) async =>
      _preferences!.setString(authTokenKey, authTokenValue);

  static getCredential() async =>
      auth = await _preferences!.getString(authTokenKey);

  static removeCredential() async => await _preferences!.remove(authTokenKey);
}
