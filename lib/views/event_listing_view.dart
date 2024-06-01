import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/job_listing_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

import '../widgets/job_details.dart';
import '../widgets/location_map.dart';

class EventListingView extends StatelessWidget {
  EventListingView({super.key});

  @override
  Widget build(BuildContext context) {
    //var args = Get.arguments;
    //var jobId = args.jobId;
    var dummytags = ["No specific skills needed;training will be provided", "Please submit your volunteer application"];
    //final jobController = Get.put(JobListingController()); // Initialize the controller

    // jobController
    //     .fetchJobPosting(jobId); // Initialize the controller with the job data

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Text(style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),"Sustainable City Initiative"),
             Text(style: TextStyle(fontSize: 10),"this is the description of volunteering")
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child:  Column(
          children: [
            Image.asset(
              'assets/images/volunteer-img.jpg',
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row( // Inner row for date and time
                  children: [
                    Icon(
                      Icons.calendar_today_outlined, // Unfilled calendar icon
                      color: Colors.black, // Adjust color as needed
                    ),
                    SizedBox(width: 8.0), // Add some spacing between icon and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                      children: [
                        Text(
                          "Saturday, June 8, 2024",
                          style: TextStyle( // Style for date
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          "9am onwards",
                          style: TextStyle( // Style for time
                            fontSize: 14.0,
                            color: Colors.grey, // Adjust color as needed
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(), // Add space between date/time and tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), // Padding for tag
                  decoration: BoxDecoration(
                    color: WorkWiseColors.primaryColor,
                    borderRadius: BorderRadius.circular(4.0), // Rounded corners for tag
                  ),
                  child: const Text(
                    "Environment",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Row(children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(width: 8.0),
              Text("Kirulopane, Colombo, Sri Lanka", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),),]),
              const SizedBox(height: 10),
              const Row(children: [
                Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 8.0),
                Text("261 applied", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                ),)
              ],),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 20),
            const Row(children: [
              Icon(
                Icons.phone,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 8.0),
              Text("Kirulopane, Colombo, Sri Lanka", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),),]),
            const SizedBox(height: 15),
            const Row(children: [
              Icon(
                Icons.email_outlined,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 8.0),
              Text("261 applied", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),)
            ],),
            SizedBox(height:15),
            Text("This is description.This is description.This is description.This is description.This is description.This is description."),
            SizedBox(height: 10),
            bulletedList(dummytags),
          ],
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
