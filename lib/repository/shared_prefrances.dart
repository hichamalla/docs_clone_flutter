import 'package:shared_preferences/shared_preferences.dart';

class LocalDataRepository {
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    return preferences.getString('token');
  }
}
