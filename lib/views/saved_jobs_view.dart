import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/search_with_filter.dart';
import 'package:get/get.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/event_card.dart';

class SavedJobsView extends StatelessWidget {
  const SavedJobsView({Key? key}) : super(key: key);

  Widget buildTagsInputChips(HomeController controller) {
    return Obx(
          () => Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
            child: SizedBox(
                    height: 60.0, // Adjust height as needed
                    child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.allTags.length,
            itemBuilder: (BuildContext context, int index) {
              final tag = controller.allTags[index];
              final isSelected = controller.selectedTags.contains(tag);

              return Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: InputChip(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  label: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isSelected
                      ? WorkWiseColors.primaryColor
                      : WorkWiseColors.greyColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  deleteIcon: isSelected
                      ? const Icon(Icons.clear, size: 20, color: Colors.white)
                      : null,
                  onDeleted: isSelected
                      ? () {
                    controller.removeTag(tag);
                  }
                      : null,
                  onPressed: () {
                    if (!isSelected) {
                      controller.addTag(tag);
                    }
                  },
                ),
              );
            },
                    ),
                  ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    // Mock data for job postings
    List<JobPosting> jobPostings = [
      JobPosting(
        id: "1",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description:
            "We are looking for a junior web developer, who is passionate about web development and has a keen eye for detail.",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "New"],
        isSaved: true,
      ),
      JobPosting(
        id: "2",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description:
            "We are looking for a junior web developer, who is passionate about web development and has a keen eye for detail.",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "Full Time", "New"],
        isSaved: true,
      ),
      JobPosting(
        id: "3",
        title: "Junior Web Developer",
        location: "CodeSphere - Colombo, Sri Lanka",
        description:
            "We are looking for a junior web developer, who is passionate about web development and has a keen eye for detail.",
        image:
            "https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png",
        salaryValue: "\$8K",
        salaryFrequency: "Mo",
        tags: ["Remote", "Full Time"],
        isSaved: true,
      ),
    ];

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
                    'Events',
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTagsInputChips(controller),
              // searchBarWithFilterIcon(
              //   searchController: TextEditingController(),
              //   colour: WorkWiseColors.primaryColor,
              //   onFilterPressed: () {
              //     // Handle filter icon press
              //   },
              // ),
              // const SizedBox(height: 15.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: jobPostings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        EventCard(
                          onCardTap: () => Get.toNamed("/profile"),
                          showDescription: false,
                          jobPosting: jobPostings[index],
                        ),
                        const SizedBox(height: 28.0),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
