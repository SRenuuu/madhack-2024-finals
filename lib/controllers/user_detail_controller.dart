import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_detail_response.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';

import 'dart:io';

class UserDetailsController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  RxBool isLoading = false.obs;

  Future<UserDetailResponse?> fetchUserData() async {
    isLoading.value = true;

    try {
      print("Fetching user data");
      final response = await apiService.sendGetRequest(
          true, // authentication is required for getUser details
          "${Constants.getUserDetailEndpoint}/${authService.getUserId()}"
      );

      isLoading.value = false;

      if (response == null) {
        authService.forceLogout();
        return null;
      }

      if (response.statusCode == HttpStatus.badRequest) {
        Get.snackbar(
          'Could not fetch your data',
          'Are you a hacker man ?',
          colorText: Colors.white,
          backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        );
        await Future.delayed(const Duration(seconds: 2));
        authService.forceLogout();
      }

      if (response.statusCode == HttpStatus.notFound ||
          response.statusCode == HttpStatus.internalServerError) {
        Get.snackbar(
          'We fucked up',
          'Server down',
          colorText: Colors.white,
          backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        );
        await Future.delayed(const Duration(seconds: 2));
        return null;
      }

      if (response.statusCode != HttpStatus.ok) {
        return null;
      }
      print(response.body);
      UserDetailResponse userDetailResponse = UserDetailResponse.fromJson(
          response.body);
      return userDetailResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

}
