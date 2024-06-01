import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/user_detail_controller.dart';
import 'package:flutter_app/models/update_user_details_request.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../models/user_detail_response.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';
import '../util/converters.dart';

class AboutMeController extends GetxController {
  UserDetailsController userDetailsController = Get.put(UserDetailsController());
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UserDetailResponse? userDetailResponse = null;

  var textFieldControllers =
      List<TextEditingController>.empty(growable: true).obs;

  void addTextField() {
    textFieldControllers.add(TextEditingController());
    update();
  }

  void removeTextField(int index) {
    textFieldControllers.removeAt(index);
    update();
  }

  void updateTextFields() {
    if (userDetailResponse == null) return;
    for(int i = 0; i < userDetailResponse!.data.profile.socialLinks.length; i++) {
      TextEditingController tc = TextEditingController();
      tc.text = userDetailResponse!.data.profile.socialLinks[i];
      textFieldControllers.add(tc);
      update();
    }
  }

  void clearTextFields() {
    textFieldControllers =
        List<TextEditingController>.empty(growable: true).obs;
    update();
  }

  void fetchData() {
    clearTextFields();
    userDetailsController.fetchUserData().then((response) => {
      userDetailResponse = response,
      if (response != null) {
        nameController.text = response.data.profile.name,
        dobController.text = response.data.profile.dob.split("T")[0],
        emailController.text = response.data.email,
        phoneController.text = response.data.profile.contact,
        updateTextFields(),

      }
    });
  }

  bool isLinksEmpty() {
    bool isEmpty = false;
    for (var element in textFieldControllers) {
      isEmpty = element.text.isEmpty;
    }
    return isEmpty;
  }

  Future<bool> updateUserData() async {

    if (emailController.text.isEmpty
        || dobController.text.isEmpty
        || nameController.text.isEmpty
        || phoneController.text.isEmpty
        || isLinksEmpty()) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
      return false;
    } else if (userDetailResponse == null) {
      Get.snackbar(
        'Error',
        'Cannot update without fetching data',
        backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        colorText: Colors.white,
      );
    }

    userDetailsController.isLoading.value = true;

    UpdateUserDetailRequest updateUserDetailRequest = mapToUpdateUserDetailRequest(userDetailResponse!);
    updateUserDetailRequest.name = nameController.text;
    updateUserDetailRequest.dob = createDateTimeWithFixedDate(dobController.text);
    updateUserDetailRequest.contact = phoneController.text;

    List<String> socialLinks = List<String>.empty(growable: true);
    for (var element in textFieldControllers) {
      socialLinks.add(element.text);
    }
    updateUserDetailRequest.socialLinks = socialLinks;


    try {
      final response = await apiService.sendPatchRequest(
        true, // authentication is required for update profile
          "${Constants.updateUserDetailEndpoint}/${authService.getUserId()}",
        data: updateUserDetailRequest.toJson(),
      );

      userDetailsController.isLoading.value = false;

      if (response == null) {
        return false;
      }

      if (response.statusCode == HttpStatus.badRequest) {
        Get.snackbar(
          'Could not update',
          'Please check your details',
          colorText: Colors.white,
          backgroundColor: Colors.orange.shade800.withOpacity(0.9),
        );
        return false;
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
        return false;
      }

      if (response.statusCode != HttpStatus.ok) {
        return false;
      }

     fetchData();
      return true;
    } catch (e) {
      return false;
    }
  }



}
