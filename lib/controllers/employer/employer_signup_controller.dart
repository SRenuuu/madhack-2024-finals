import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/signup_request.dart';
import '../../services/api_service.dart';
import '../../util/constants.dart';

class EmployerSignUpController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isRegisterLoading = false.obs;

  @override
  void onInit() {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    super.onInit();
  }

  Future<bool> register() async {
    // check if all fields are filled
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
      return false;
    }

    // check if password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
      return false;
    }

    isRegisterLoading.value = true;

    SignUpRequest signUpRequest = SignUpRequest(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        role: "employer");

    try {
      final response = await apiService.sendPostRequest(
        false, // authentication is not required for login
        Constants.registerEndpoint,
        data: signUpRequest.toJson(),
      );

      isRegisterLoading.value = false;

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

      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      confirmPasswordController.text = "";
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
