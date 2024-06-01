import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';

class LoginController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoginLoading = false.obs;

  @override
  void onInit() {
    emailController.text = "";
    passwordController.text = "";
    super.onInit();
  }

  Future<bool> login() async {
    // check if all fields are filled
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
      return false;
    }

    isLoginLoading.value = true;

    LoginRequest loginRequest = LoginRequest(
        email: emailController.text, password: passwordController.text);
    try {
      final response = await apiService.sendPostRequest(
        false, // authentication is not required for login
        Constants.loginEndpoint,
        data: loginRequest.toJson(),
      );

      isLoginLoading.value = false;

      if (response == null) {
        return false;
      }

      if (response.statusCode == HttpStatus.badRequest) {
        Get.snackbar(
          'Validation failed',
          'Please check your email and password',
          colorText: Colors.white,
          backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        );
      }

      if (response.statusCode == HttpStatus.notFound ||
          response.statusCode == HttpStatus.forbidden) {
        Get.snackbar(
          'Error',
          'Invalid email or password',
          colorText: Colors.white,
          backgroundColor: Colors.red.shade700.withOpacity(0.9),
        );
      }

      if (response.statusCode != HttpStatus.ok) {
        return false;
      }

      LoginResponse loginResponse = LoginResponse.fromJson(response.body);

      final authService = Get.find<AuthService>();

      authService.setUserEmail(loginResponse.data.email);
      authService.setAuthentication(true);
      authService.setBearerToken(loginResponse.data.token);
      authService.setUserId(loginResponse.data.id);
      authService.setUserRole(loginResponse.data.role);

      emailController.text = "";
      passwordController.text = "";
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
