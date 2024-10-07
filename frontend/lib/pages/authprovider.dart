import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _jwt;

  String? get jwt => _jwt;

  AuthProvider() {
    _loadJwt();
  }

  void _loadJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _jwt = prefs.getString('jwt');
    notifyListeners();
  }

  void setJwt(String jwt) async {
    _jwt = jwt;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', jwt);
    notifyListeners();
  }

  void logout() async {
    _jwt = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    notifyListeners();
  }
}
