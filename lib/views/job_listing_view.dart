import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/job_listing_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

import '../widgets/job_details.dart';
import '../widgets/location_map.dart';

class JobListingPage extends StatelessWidget {
  JobListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    var jobId = args.jobId;
    final jobController =
        Get.put(JobListingController()); // Initialize the controller

    jobController
        .fetchJobPosting(jobId); // Initialize the controller with the job data

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
        title: const Text("Job Listing"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => jobHeader(
                    jobController.jobTitle.value,
                    jobController.location.value,
                    jobController.companyName.value),
              ),
              const SizedBox(height: 24),
              Obx(() => JobDetails(
                    jobType: jobController.tags.value[0],
                    employmentType: "",
                    salaryRange: jobController.salaryRange.value,
                    salaryFrequency: "Mo",
                    salaryValue: jobController.salaryRange.value,
                  )),
              const SizedBox(height: 24),
              const Text(
                "Job Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WorkWiseColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(jobController.jobDescription.value)),
              const SizedBox(height: 24),
              const Text(
                "Requirements",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WorkWiseColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => bulletedList(jobController.requirements.value)),
              const SizedBox(height: 24),
              const Text(
                "Responsibilities",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WorkWiseColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => bulletedList(jobController.responsibilities.value)),
              const SizedBox(height: 24),
              const Text(
                "About Company",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WorkWiseColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(jobController.companyDescription.value)),
              const SizedBox(height: 16),
              Obx(() => locationMap(
                  jobController.latitude.value, jobController.longitude.value)),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 85,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: actionButtons(),
        ),
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: OutlinedButton(
            onPressed: () {
              // Add functionality to save the job listing
            },
            child: const Icon(Icons.bookmark),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed('/resume');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Apply Now",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget bulletedList(List<String> items) {
    return Column(
      children: items.map((item) => listItem(text: item)).toList(),
    );
  }

  Widget jobHeader(String jobTitle, String location, String companyName) {
    return Row(
      children: [
        // Widget to display the job icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://foyr.com/learn/wp-content/uploads/2021/08/modern-office-design.png'),
              // Replace with your image URL
              fit: BoxFit.cover, // Adjust fit as needed (cover, contain, etc.)
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    companyName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WorkWiseColors.secondaryColor,
                    ),
                  ),
                  Text(
                    " - $location",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listItem({required String text}) {
    return Row(
      children: [
        const Icon(
          Icons.circle,
          size: 8,
          color: Colors.blueGrey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
