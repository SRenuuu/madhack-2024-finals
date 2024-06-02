import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerController extends GetxController {
  Rx<File?> selectedMedia = Rx<File?>(null);
  RxBool isImage = true.obs;

  Future<void> pickMedia(bool pickImage) async {
    PermissionStatus status = await (pickImage
        ? Permission.photos.status
        : Permission.storage.status);

    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedMedia.value = File(pickedFile.path);
        isImage.value = pickImage;
      }
    } else {
      if (pickImage) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }

      if (status.isGranted) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedMedia.value = File(pickedFile.path);
          isImage.value = pickImage;
        }
      } else {
        Get.snackbar(
          'Permission Denied',
          'Permission to access ${pickImage ? 'photos' : 'storage'} was denied. Please enable it in settings.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
