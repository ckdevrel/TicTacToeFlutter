import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  static final String gameURL = "game_url";

  static Future<bool> setGameUrl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(gameURL, value);
  }

  static Future<String> getGameUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(gameURL);
  }
}