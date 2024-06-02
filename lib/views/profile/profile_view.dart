import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/login_controller.dart';
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
    LoginController loginController = Get.put(LoginController());

    List<ProfileSection> profileSections = [
      ProfileSection(
          title: 'About Me',
          icon: CupertinoIcons.profile_circled,
          onTap: () => Get.toNamed("/about-me")),
      ProfileSection(
          title: 'Skills',
          icon: CupertinoIcons.briefcase,
          onTap: () => Get.toNamed("/all-experiences")),
      ProfileSection(
          title: 'Certifications',
          icon: CupertinoIcons.book,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EducationPage()))),
      ProfileSection(
          title: 'Feedback',
          icon: CupertinoIcons.hand_draw,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SkillsPage()))),
    ];

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
                  _buildProfileHeader(),
                  // Events, Followers, Following section
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // Distribute evenly
                    children: [
                      buildCountColumn("Events", 100),
                      buildCountColumn("Followers", 524),
                      buildCountColumn("Following", 38),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        buildSettingRow("Notifications", Icons.notifications),
                        buildSettingRow("Privacy Settings", Icons.lock),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ...profileSections.map((section) => _buildProfileSectionCard(
                        title: section.title,
                        icon: section.icon,
                        onTap: section.onTap,
                      )),
                  const SizedBox(height: 24.0),
                  _buildProfileSectionCard(
                    textColor: Colors.red.shade700,
                    iconColor: Colors.red.shade700,
                    title: "Logout",
                    icon: CupertinoIcons.square_arrow_right,
                    onTap: () {
                      loginController.logout();
                    },
                    showArrow: false,
                  )
                ],
              ),
            ),
          ),
        ));
  }

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

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            // The CircleAvatar
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: WorkWiseColors.greyColor.withOpacity(0.35),
                    blurRadius: 24.0,
                    offset: const Offset(0, 4.0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: WorkWiseColors.secondaryColor,
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                      "https://www.shareicon.net/data/512x512/2015/09/18/103160_man_512x512.png", // Replace with user's profile image
                    ),
                    backgroundColor: Colors
                        .transparent, // Set background color to transparent
                  ),
                ],
              ),
            ),

            // The camera icon button
            // make this smaller

            Positioned(
              width: 45,
              bottom: 0,
              right: 0,
              child: Container(
                // make this smaller
                // circle this container
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WorkWiseColors.primaryColor.withOpacity(1),
                ),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.camera_fill, size: 20),
                  color: Colors.white, // White color for the icon
                  onPressed: () {
                    // give haptic feedback
                    HapticFeedback.lightImpact();
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        const Text(
          'Sandul Renuja',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        const SizedBox(height: 2.0),
        const Text(
          'sandulrenuja@gmail.com',
          style: TextStyle(fontSize: 16, color: WorkWiseColors.darkGreyColor),
        ),
        const SizedBox(height: 8.0),
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
        Switch(value: false, onChanged: (value) => {}),
        // Replace with functionality
      ],
    );
  }

  Widget _buildProfileSectionCard({
    required String title,
    required IconData icon,
    required VoidCallback? onTap,
    bool showShadow = true,
    Color iconColor = WorkWiseColors.primaryColor,
    Color textColor = Colors.black,
    bool showArrow = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          showShadow
              ? BoxShadow(
                  color: WorkWiseColors.greyColor.withOpacity(0.35),
                  blurRadius: 16.0,
                  offset: const Offset(0, 4.0),
                  spreadRadius: 0,
                )
              : const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          overlayColor: MaterialStateProperty.all(WorkWiseColors.greyColor),
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 24.0, color: iconColor),
                    const SizedBox(width: 20.0),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    )
                  ],
                ),
                showArrow
                    ? const Icon(CupertinoIcons.chevron_forward,
                        size: 20.0, color: WorkWiseColors.darkGreyColor)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSection {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  ProfileSection({required this.title, required this.icon, this.onTap});
}
