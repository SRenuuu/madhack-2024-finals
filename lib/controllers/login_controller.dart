import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firebase_auth_service.dart';
import 'package:get/get.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_data_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';

class LoginController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  FirebaseAuthService authService = Get.put(FirebaseAuthService());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoginLoading = false.obs;

  @override
  void onInit() {
    emailController.text = "";
    passwordController.text = "";
    super.onInit();
  }

  Future<UserData?> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
      return null;
    }

    isLoginLoading.value = true;
    return await authService.signIn(emailController.text, passwordController.text);
  }

  // implement logout
  Future<void> logout() async {
    await authService.signOut();
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
