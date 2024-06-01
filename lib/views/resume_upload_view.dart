import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/resume_upload_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

class ResumeUploadView extends StatelessWidget {
  const ResumeUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    ResumeUploadController controller = Get.put(ResumeUploadController());

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20.0),
                      const Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senior Creative Designer',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'codeX Labs - Colombo, Sri Lanka',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'CV',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _buildUploadField((MultipartFile file) {
                    controller.uploadResume(file);
                  }),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _buildMessageTextArea(controller.messageController),
                  const SizedBox(height: 40.0),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadField(Function(MultipartFile) onFilePicked) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_upload),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Text(
              'Upload your CV',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                String? filePath = result.files.single.path;
              } else {
                // User canceled the picker
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTextArea(TextEditingController messageController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        controller: messageController,
        maxLines: 10,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: WorkWiseColors.darkGreyColor ),
          hintText: 'Enter your message...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.offAllNamed('/home');
        },
        child: const Text('Submit'),
      ),
    );
  }
}
