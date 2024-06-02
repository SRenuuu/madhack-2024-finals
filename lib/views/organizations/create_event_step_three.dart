import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/organizations/create_event_controller.dart';
import 'package:flutter_app/views/organizations/tags_input.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../theme/colors.dart';

class CreateEventStepThreePage extends StatefulWidget {
  const CreateEventStepThreePage({Key? key}) : super(key: key);

  @override
  _CreateEventStepThreePageState createState() =>
      _CreateEventStepThreePageState();
}

class _CreateEventStepThreePageState extends State<CreateEventStepThreePage> {
  final CreateEventController controller = Get.put(CreateEventController());
  final TextEditingController textEditingController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    // Check if permission is granted
    PermissionStatus status = await Permission.photos.status;

    // If permission is granted, proceed to pick image

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        controller.selectedImages.add(_image!.path);
      }
    });

    // If permission is denied but not permanently, request permission
    // else if (status.isDenied || status.isRestricted || status.isLimited) {
    //   // Request permission
    //   status = await Permission.photos.request();
    //   if (status.isGranted) {
    //     final pickedFile =
    //         await ImagePicker().pickImage(source: ImageSource.gallery);
    //     setState(() {
    //       if (pickedFile != null) {
    //         _image = File(pickedFile.path);
    //       }
    //     });
    //   } else {
    //     Get.snackbar(
    //       'No Permissions',
    //       'App requires permission to access photos',
    //       colorText: Colors.white,
    //       backgroundColor: Colors.orange.shade800.withOpacity(0.9),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text('Create Event'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Icon(Icons.circle,
                          size: 12,
                          color: Colors
                              .grey // Highlight the first dot if it's the current step
                          ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Icon(
                        size: 12,
                        Icons.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Icon(
                        size: 12,
                        Icons.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                // Editable form
                Container(
                  padding: EdgeInsets.all(12), // Add padding for spacing
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius: BorderRadius.circular(
                        8), // Apply border radius for rounded corners
                    border: Border.all(
                        color:
                            Colors.grey), // Add border for the rectangle look
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _getImage,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 40,
                                color: WorkWiseColors.primaryColor,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Upload Image or Video',
                                style: TextStyle(
                                  color: WorkWiseColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tags',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                    TagsInputField(),
                    // Add other form fields as needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 85,
        elevation: 0,
        child: actionButtons(),
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (await controller.handleCreateEvent()) {
                Get.snackbar(
                  'Success',
                  'Event created successfully',
                  colorText: Colors.white,
                  backgroundColor: Colors.green.shade800.withOpacity(0.9),
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to create event',
                  colorText: Colors.white,
                  backgroundColor: Colors.red.shade800.withOpacity(0.9),
                );
              }
              ;
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Next",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
