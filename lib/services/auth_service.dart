import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  final RxString email = ''.obs;
  final RxString userId = ''.obs;
  final RxBool isAuthenticated = false.obs;
  String _bearerToken = '';
  String userRole = '';

  SharedPreferences? _prefs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    email.value = _prefs?.getString('email') ?? '';
    userId.value = _prefs?.getString('_id') ?? '';
    isAuthenticated.value = _prefs?.getBool('isAuthenticated') ?? false;
    _bearerToken = _prefs?.getString('bearerToken') ?? '';
    userRole = _prefs?.getString('userRole') ?? '';
  }

  String getBearerToken() {
    if (_bearerToken == '') {
      _bearerToken = _prefs?.getString('bearerToken') ?? '';
    }

    return _bearerToken;
  }

  String getUserEmail() {
    return email.value;
  }

  String getUserId() {
    return userId.value;
  }

  void setBearerToken(String newToken) {
    _bearerToken = newToken;
    _prefs?.setString('bearerToken', newToken);
  }

  void setUserEmail(String newEmail) {
    email.value = newEmail;
    _prefs?.setString('email', newEmail);
  }

  void setUserId(String newId) {
    userId.value = newId;
    _prefs?.setString('_id', newId);
  }

  void setAuthentication(bool value) {
    isAuthenticated.value = value;
    _prefs?.setBool('isAuthenticated', value);
  }

  void setUserRole(String role) {
    userRole = role;
    _prefs?.setString('userRole', role);
  }

  String getUserRole() {
    return userRole;
  }

  void forceLogout() {
    if (kDebugMode) {
      print("Logging out");
    }
    // Clear stored authentication data
    _prefs?.remove('email');
    _prefs?.remove('bearerToken');
    _prefs?.remove('isAuthenticated');
    _prefs?.remove('userRole');
    _prefs?.remove('_id');

    // Remove all routes and get to LoginScreen()
    Get.offAllNamed('/login');
  }
}
