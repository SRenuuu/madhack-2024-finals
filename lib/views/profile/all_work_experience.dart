import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/all_work_experience_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/util/arguments.dart';
import 'package:get/get.dart';

import '../../widgets/job_experience_class.dart';
import '../../widgets/loading_indicator.dart';

class AllWorkExperiencePage extends StatelessWidget {
  const AllWorkExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    AllWorkExperienceController allWorkExperienceController = Get.put(AllWorkExperienceController());
    allWorkExperienceController.fetchData();

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Experiences'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Obx(() =>
              allWorkExperienceController.userDetailsController.isLoading.value
                  ? loadingIndicator() :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 8.0),
                  Obx(() => ListView.builder(
                    itemCount: allWorkExperienceController.jobExperiences.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          JobExperienceCard(
                            company: allWorkExperienceController.jobExperiences[index].company,
                            description: allWorkExperienceController.jobExperiences[index].description,
                            startDate: allWorkExperienceController.jobExperiences[index].startDate,
                            endDate: allWorkExperienceController.jobExperiences[index].endDate,
                            isCurrent: allWorkExperienceController.jobExperiences[index].isCurrent,
                            position: allWorkExperienceController.jobExperiences[index].position,
                            onDelete: () => {},
                            onEdit: () => {
                              Get.toNamed("/work-experience", arguments: WorkExperienceViewArguments(isNew: false, userDetailResponse: allWorkExperienceController.getUserDetailResponse(), workExperience: allWorkExperienceController.jobExperiences[index]
                              ))
                            },
                          )
                        ],
                      );
                    },
                  )),
                  const SizedBox(height: 8.0),

                ],
              ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          height: 85,
          elevation: 0,
          child: actionButtons(() => Get.toNamed("/work-experience",  arguments: WorkExperienceViewArguments(isNew: true, userDetailResponse: allWorkExperienceController.getUserDetailResponse()))),
        ));
  }

  // Reusable action buttons
  Widget actionButtons(Function onAddNew) {
    return Row(
      children: [
        const SizedBox(width: 24),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              onAddNew();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Add new",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // Reusable link widget
  Widget buildLink(String value, void Function(String?)? onSaved) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
              onSaved: onSaved,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () => {}, // delete
          ),
        ],
      ),
    );
  }

  // Reusable mobile number field
  Widget buildMobileNumberField(
      String code,
      String number,
      void Function(String?)? onCodeChange,
      void Function(String?)? onNumberChange) {
    return Row(
      children: [
        DropdownButton<String>(
          value: code,
          items: const [
            DropdownMenuItem(
              value: "+1",
              child: Text("+1 (US)"),
            ),
            DropdownMenuItem(
              value: "+94",
              child: Text("+94 (LK)"),
            ),
            // Add more countries as needed
          ],
          onChanged: onCodeChange,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            initialValue: number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.phone,
            onSaved: onNumberChange,
          ),
        ),
      ],
    );
  }
}
