import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/search_with_filter.dart';
import 'package:get/get.dart';

import '../widgets/job_card.dart';

class SavedJobsView extends StatelessWidget {
  const SavedJobsView({Key? key}) : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Saved Jobs"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  searchBarWithFilterIcon(
                    searchController: TextEditingController(),
                    colour: WorkWiseColors.primaryColor,
                    onFilterPressed: () {
                      // Handle filter icon press
                    },
                  ),
                  const SizedBox(height: 15.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: jobPostings.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          JobCard(
                            onCardTap: () => Get.toNamed("/profile"),
                            showDescription: false,
                            jobPosting: jobPostings[index],
                          ),
                          const SizedBox(height: 15.0),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
