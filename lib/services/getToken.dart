import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token');
}
