import 'package:get/get.dart';

import '../models/resume_data.dart';
import 'api_service.dart';

class ResumeUploadService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<bool> uploadResume(ResumeData resumeData) async {
    try {
      print(resumeData);
      return true; // If upload is successful
    } catch (e) {
      print(e);
      return false;
    }
  }
}
