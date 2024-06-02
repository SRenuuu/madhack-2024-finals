import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drawer.dart';
import '../../widgets/form_text_field.dart';

class Manageapplicationhomepage extends StatelessWidget {
  const Manageapplicationhomepage({Key? key});

  @override
  Widget build(BuildContext context) {
    // final drawerController = AdvancedDrawerController();
    final HomeController controller = Get.put(HomeController());

    return AdvancedDrawer(
      controller: controller.drawerController,
      drawer: CustomDrawer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the row content
              children: [
                SizedBox(
                  width: 24,
                  child: GestureDetector(
                    child: const Icon(Icons.menu),
                    onTap: controller.handleDrawerToggle,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Manage Applications',
                    textAlign:
                        TextAlign.center, // Center the text within Flexible
                  ),
                ),
                const SizedBox(
                  width: 24,
                  child: null,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearchField(context),
                const SizedBox(height: 24.0),
                buildFeaturedEvents(),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildProfileIcons() {
  //   return Row(
  //     children: [
  //       IconButton(
  //         onPressed: () => Get.toNamed("/saved-jobs"),
  //         icon: const Icon(
  //           Icons.bookmarks_rounded,
  //           size: 24,
  //           color: WorkWiseColors.tertiaryColor,
  //         ),
  //       ),
  //       const SizedBox(width: 12.0),
  //       buildProfileIconButton(),
  //     ],
  //   );
  // }
  //
  // Widget buildProfileIconButton() {
  //   return Container(
  //     width: 42.0,
  //     height: 42.0,
  //     decoration: const BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: WorkWiseColors.lightGreyColor,
  //     ),
  //     child: IconButton(
  //       onPressed: () => Get.toNamed("/profile"),
  //       icon: const Icon(
  //         Icons.person,
  //         size: 24,
  //         color: WorkWiseColors.primaryColor,
  //       ),
  //     ),
  //   );
  // }

  Widget buildSearchField(context) {
    HomeController controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: formTextField(
              showBorder: true,
              isDense: true,
              hintText: 'Search Applications...',
              showLabel: false,
              label: 'Search Events',
              prefixIcon: const Icon(Icons.search,
                  size: 26.0, color: WorkWiseColors.primaryColor),
              controller: controller.searchController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFeaturedEvents() {
    HomeController controller = Get.put(HomeController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildApplicationCard(
                    title: 'Received',
                    count: '3',
                  ),
                  buildApplicationCard(
                    title: 'Approved',
                    count: '1',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildApplicationCard(
                    title: 'Rejected',
                    count: '0',
                  ),
                  buildApplicationCard(
                    title: 'Pending',
                    count: '3',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildApplicationCard({required String title, required String count}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == 'Received') {
            Get.toNamed('/manage-application-received');
          }
        },
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          child: Container(
            color: WorkWiseColors.lightGreyColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    count,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: WorkWiseColors.secondaryColor,
              ),
            ),
            SizedBox(width: 20.0),
            Text(
              'Loading...',
              style: TextStyle(
                color: WorkWiseColors.darkGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomArg {
  final String jobId;

  CustomArg(this.jobId);
}
