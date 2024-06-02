import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/profile_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // get auth service
    ProfileController profileController = Get.put(ProfileController());
    return Drawer(
      child: Container(
        child: Column(
          children: [
            // Container with profile picture and name
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 48, 24.0, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/profile');
                      },
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.shareicon.net/data/512x512/2015/09/18/103160_man_512x512.png'),
                        radius: 35.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Obx(() => Text(profileController.name.value,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white))),
                  ],
                ),
              ),
            ),
            const Divider(height: 1.0),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.home),
              ),
              title: const Text('Home'),
              onTap: () {
                // Handle home navigation
                Get.toNamed('/create-event');
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.apps),
              ),
              title: const Text('Applications'),
              onTap: () {
                // Handle applications navigation
                Get.toNamed('/manage-application');
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.school),
              ),
              title: const Text('Events'),
              onTap: () {
                // Handle programs navigation
                Get.toNamed('/saved-jobs');
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.people),
              ),
              title: const Text('Volunteers'),
              onTap: () {
                // Handle volunteers navigation
                Get.toNamed('/create-event');
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              ),
              title: const Text('Notifications'),
              onTap: () {
                // Handle notifications navigation
                Get.toNamed('/create-event');
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.chat),
              ),
              title: const Text('Chats'),
              onTap: () {
                // Handle chats navigation
                Get.toNamed('/create-event');
              },
            ),
          ],
        ),
      ),
    );
  }
}
