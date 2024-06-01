import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/user_detail_controller.dart';
import 'package:get/get.dart';

import '../models/update_user_details_request.dart';
import '../models/user_detail_response.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';
import '../util/converters.dart';

class WorkExperienceController extends GetxController {
  UserDetailsController userDetailsController = Get.find<UserDetailsController>();
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  UserDetailResponse? userDetailResponse = null;
  WorkExperience? workExperience = null;

  Rx<bool> isCurrentJob = false.obs;

  void changeIsCurrentJob() {
    isCurrentJob.value = !isCurrentJob.value;
  }


  void setData(UserDetailResponse? userDetailResponse1, WorkExperience? workExperience1)  {
    jobTitleController.text = workExperience1!.position;
    companyController.text = workExperience1!.company;
    startDateController.text = workExperience1!.startDate.toString().split("T")[0];
    endDateController.text = workExperience1!.endDate.toString().split("T")[0];
    descriptionController.text = workExperience1!.description;

    userDetailResponse = userDetailResponse1;
    workExperience = workExperience1;
  }

  void startAddNew() {
    jobTitleController.text = "";
    companyController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    descriptionController.text = "";
  }

  Future<bool> updateExperience() async {

    if (jobTitleController.text.isEmpty
        || companyController.text.isEmpty
        || startDateController.text.isEmpty
        || endDateController.text.isEmpty) {
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

    Iterable<WorkExperience>? workExperiences = userDetailResponse?.data.profile.workExperience.where((element) => element.id != workExperience?.id);
    WorkExperience? workExperiencesEdit = userDetailResponse?.data.profile.workExperience.where((element) => element.id == workExperience?.id).firstOrNull;
    workExperiencesEdit?.description = descriptionController.text;
    workExperiencesEdit?.company = companyController.text;
    workExperiencesEdit?.position = jobTitleController.text;

    userDetailResponse?.data.profile.workExperience = workExperiences!.toList();
    userDetailResponse?.data.profile.workExperience.add(workExperiencesEdit!);
    UpdateUserDetailRequest updateUserDetailRequest = mapToUpdateUserDetailRequest(userDetailResponse!);


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

      // fetchData();
      return true;
    } catch (e) {
      return false;
    }
  }


  Future<bool> addNewExperience() async {

    if (jobTitleController.text.isEmpty
        || companyController.text.isEmpty
        || startDateController.text.isEmpty
        || endDateController.text.isEmpty) {
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
    WorkExperienceUpdate wk = WorkExperienceUpdate(
      company: companyController.text,
      description: descriptionController.text,
      isCurrent: false,
      position: jobTitleController.text,
      endDate: createDateTimeWithFixedDate(endDateController.text),
      startDate: createDateTimeWithFixedDate(startDateController.text),
    );

    updateUserDetailRequest.workExperience.add(wk);


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

      // fetchData();
      return true;
    } catch (e) {
      return false;
    }
  }


}