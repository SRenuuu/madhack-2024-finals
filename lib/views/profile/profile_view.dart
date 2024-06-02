import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/profile_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/views/profile/education_view.dart';
import 'package:flutter_app/views/profile/qualification_view.dart';
import 'package:flutter_app/views/profile/skills_view.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
    children: [
    // Profile section
    Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
    children: [
    CircleAvatar(
    radius: 50.0, // Adjust image size as needed
    backgroundImage: NetworkImage("https://placeimg.com/640/480/people"), // Replace with user's image
    ),
    SizedBox(height: 16.0),
    Text(
    "John Doe", // Replace with user's name
    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    Text(
    "123 Main Street, Anytown, CA 12345", // Replace with user's address
    style: TextStyle(fontSize: 14.0, color: Colors.grey),
    ),
    ],
    ),
    ),
      SizedBox(height: 20.0),

    // Events, Followers, Following section
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute evenly
    children: [
    buildCountColumn("Events", 100),
    buildCountColumn("Followers", 524),
    buildCountColumn("Following", 38),
    ],
    ),

    // Settings section
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
    children: [
    buildSettingRow("Notifications", Icons.notifications),
    buildSettingRow("Privacy Settings", Icons.lock),
    ],
    ),
    ),

    // More options section
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
    children: [
    buildOptionRow("Skills", Icons.task_alt),
      SizedBox(height: 15.0),
    buildOptionRow("Certification", Icons.celebration),
      SizedBox(height: 15.0),
    buildOptionRow("Feedback", Icons.feedback),
    ],
    ),
    ),
    ],
    ),))));

  }

  // Reusable widgets for building sections
  Widget buildCountColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15.0),
        Text(
          label,
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildSettingRow(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 15.0),
        Text(text),
        Spacer(),
        Switch(value: false, onChanged: (value) => {}), // Replace with functionality
      ],
    );
  }

  Widget buildOptionRow(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8.0),
        Text(text),
        Spacer(),
        Icon(Icons.navigate_next),
      ],
    );
  }
}

