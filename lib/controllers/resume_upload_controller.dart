import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/resume_data.dart';
import '../services/resume_upload_service.dart';

class ResumeUploadController extends GetxController {
  final ResumeUploadService resumeService = Get.find<ResumeUploadService>();
  final TextEditingController messageController = TextEditingController();
  final RxBool isResumeUploading = false.obs;

  Future<void> uploadResume(MultipartFile resumeFile) async {
    try {
      isResumeUploading.value = true;
      String message = messageController.text;

      ResumeData resumeData = ResumeData(
        resumeFile: resumeFile,
        message: message,
      );

      bool success = await resumeService.uploadResume(resumeData);
      if (success) {

        print('Resume uploaded successfully');
      } else {

        print('Failed to upload resume');
      }
    } finally {
      isResumeUploading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}

