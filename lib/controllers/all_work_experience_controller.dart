import 'package:flutter_app/controllers/user_detail_controller.dart';
import 'package:flutter_app/models/user_detail_response.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';


class AllWorkExperienceController extends GetxController {
  UserDetailsController userDetailsController = Get.put(UserDetailsController());
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  UserDetailResponse? userDetailResponse = null;

  UserDetailResponse? getUserDetailResponse() {
    return userDetailResponse;
  }

  var jobExperiences =
      List<WorkExperience>.empty(growable: true).obs;

  void updateExperienceList() {
    userDetailResponse?.data.profile.workExperience.forEach((element) {
      jobExperiences.add(element);
    });
  }

  void preventFetch() {

  }

  void fetchData() async {
    jobExperiences = List<WorkExperience>.empty(growable: true).obs;
    userDetailsController.fetchUserData().then((response) => {
      userDetailResponse = response,
      if (response != null) {
        updateExperienceList(),
      }
    });
  }
}