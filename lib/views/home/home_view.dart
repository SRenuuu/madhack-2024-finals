import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drawer.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/event_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

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
              mainAxisAlignment: MainAxisAlignment.center, // Center the row content
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
                    'Home',
                    textAlign: TextAlign.center, // Center the text within Flexible
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
                buildOrgsList(),
                const SizedBox(height: 20.0),
                buildYourEvents(context),
                const SizedBox(height: 40.0),
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
              hintText: 'Search Events...',
              showLabel: false,
              label: 'Search Events',
              prefixIcon: const Icon(Icons.search,
                  size: 26.0, color: WorkWiseColors.primaryColor),
              controller: controller.searchController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: IconButton(
                onPressed: () => {Get.toNamed("/search-filters")},
                icon: const Icon(Icons.filter_list_sharp,
                    size: 28.0, color: WorkWiseColors.darkGreyColor),
              ),
            ),
          )
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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Featured Events",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () => {print("View all events")},
                child: const Text(
                  "View all",
                  style: TextStyle(
                    color: WorkWiseColors.secondaryColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.isOrgsLoading.value
            ? _buildLoadingIndicator()
            : controller.featuredEvents.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text(
                        "No featured events yet",
                        style: TextStyle(
                          color: WorkWiseColors.darkGreyColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 265.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.featuredEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                            top: 16.0,
                            bottom: 24.0,
                            left: index == 0 ? 24.0 : 0,
                            right: index == 9 ? 24.0 : 16.0,
                          ),
                          child: EventCard(
                            showDescription: false,
                            shadowColor:
                                WorkWiseColors.greyColor.withOpacity(0.5),
                            onCardTap: () => {print("Not implemented")},
                            eventPosting: controller.featuredEvents[index],
                          ),
                        );
                      },
                    ),
                  )),
      ],
    );
  }

  Widget buildOrgsList() {
    // Replace 'List<String>' with your actual data list of avatar URLs and names
    final List<String> avatars = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      // Add more avatar URLs as needed
    ];
    final List<String> names = [
      'Name 1 iuhbiuh buyhyb',
      'Name 2',
      'Name 3',
      'Name 4',
      'Name 5',
      'Name 6',
      // Add more names as needed
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Adjust title padding
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Organizations",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () => {print("View all events")},
                child: const Text(
                  "View all",
                  style: TextStyle(
                    color: WorkWiseColors.secondaryColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0), // Adjust top margin below title
        SizedBox(
          height: 100.0, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: avatars.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 72,
                margin: EdgeInsets.only(
                  left: index == 0 ? 24.0 : 0,
                  right: index == 9 ? 24.0 : 16.0,
                ),
                child: Column(
                  children: [
                    // Avatar image in a circle
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatars[index]),
                      radius: 36.0,
                    ),
                    const SizedBox(height: 8.0),
                    // Adjust spacing between avatar and text
                    // Text label below the avatar
                    Text(
                      overflow: TextOverflow.ellipsis,
                      names[index],
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildYourEvents(context) {
    HomeController controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Events",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16.0),
          Obx(() => controller.isFeaturedEventsLoading.value
              ? _buildLoadingIndicator()
              : controller.featuredEvents.isEmpty
                  ? const Center(
                      child: Text(
                        "No recommended jobs found",
                        style: TextStyle(
                          color: WorkWiseColors.darkGreyColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.featuredEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EventCard(
                            shadowColor:
                                WorkWiseColors.greyColor.withOpacity(0.5),
                            onCardTap: () => Get.toNamed("/job",
                                arguments: CustomArg(
                                    controller.featuredEvents[index].id)),
                            eventPosting: controller.featuredEvents[index],
                          ),
                        );
                      },
                    )),
        ],
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