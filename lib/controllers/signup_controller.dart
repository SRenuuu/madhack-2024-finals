import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_data_model.dart';
import '../services/firebase_auth_service.dart';

class SignUpController extends GetxController {
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

    try {
      isRegisterLoading.value = true;
      UserData? userData = await Get.find<FirebaseAuthService>()
          .register(emailController.text, passwordController.text, 'volunteer');

      if (userData != null) {
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to register',
          backgroundColor: Colors.orange.shade800.withOpacity(0.9),
          colorText: Colors.white,
        );
        // nameController.text = "";
        // emailController.text = "";
        // passwordController.text = "";
        // confirmPasswordController.text = "";
        return false;
      }
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
