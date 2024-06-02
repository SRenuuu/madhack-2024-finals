import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                    CircleAvatar(
                      // Replace with your logic to load profile picture
                      backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                      radius: 35.0,
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      'User Name', // Replace with user's actual name
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1.0),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.home),
              ),
              title: const Text('Home'),
              onTap: () {
                // Handle home navigation
                Get.back();
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.apps),
              ),
              title: const Text('Applications'),
              onTap: () {
                // Handle applications navigation
                Get.back();
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.school),
              ),
              title: const Text('Programs'),
              onTap: () {
                // Handle programs navigation
                Get.back();
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.people),
              ),
              title: const Text('Volunteers'),
              onTap: () {
                // Handle volunteers navigation
                Get.back();
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.notifications),
              ),
              title: const Text('Notifications'),
              onTap: () {
                // Handle notifications navigation
                Get.back();
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.chat),
              ),
              title: const Text('Chats'),
              onTap: () {
                // Handle chats navigation
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}