import 'package:flutter/material.dart';
import 'package:flutter_app/util/arguments.dart';
import 'package:get/get.dart';

import '../../controllers/work_experience_controller.dart';
import '../../theme/colors.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/loading_indicator.dart';

class WorkExperiencePage extends StatelessWidget {
  const WorkExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    WorkExperienceController controller = Get.put(WorkExperienceController());
    final WorkExperienceViewArguments workExperienceViewArguments = Get.arguments;
    Function onTap = () => {};
    String buttonText = "";
    if (!workExperienceViewArguments.isNew) {
      controller.setData(workExperienceViewArguments.userDetailResponse, workExperienceViewArguments.workExperience);
      buttonText = "Update";
      onTap = () => {
        controller.updateExperience()
      };
    }
    else {
      controller.startAddNew();
      buttonText = "Add new";
      onTap = () => {
      controller.addNewExperience()
      };
    }

    selectStartDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.startDateController.text == ''
            ? DateTime.now()
            : DateTime.parse(controller.startDateController.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      controller.startDateController.text =
      pickedDate != null ? pickedDate.toString().split(' ')[0] : '';
    }

    selectEndDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.endDateController.text == ''
            ? DateTime.now()
            : DateTime.parse(controller.endDateController.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      controller.endDateController.text =
      pickedDate != null ? pickedDate.toString().split(' ')[0] : '';
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Add or Update Experience'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Obx(() =>
              controller.userDetailsController.isLoading.value
                  ? loadingIndicator() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Editable form
                    formTextField(
                      label: 'Job title',
                      controller: controller.jobTitleController,
                      prefixIcon: const Icon(Icons.person,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                    ),
                    const SizedBox(height: 24.0),
                    formTextField(
                      label: 'Company',
                      controller: controller.companyController,
                      prefixIcon: const Icon(Icons.house,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                    ),
                    const SizedBox(height: 24.0),
                    CheckboxListTile(value: controller.isCurrentJob.value, onChanged: (newValue) => controller.changeIsCurrentJob(), title: const Text("Current job"), controlAffinity: ListTileControlAffinity.leading),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          child: formTextField(
                            label: 'Start Date',
                            controller: controller.startDateController,
                            keyboardType: TextInputType.datetime,
                            hintText: 'YYYY-MM-DD',
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today,
                                  size: 20.0, color: WorkWiseColors.primaryColor),
                              onPressed: () => selectStartDate(context),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: formTextField(
                            label: 'End Date',
                            controller: controller.endDateController,
                            keyboardType: TextInputType.datetime,
                            hintText: 'YYYY-MM-DD',
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today,
                                  size: 20.0, color: WorkWiseColors.primaryColor),
                              onPressed: () => selectEndDate(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    formTextField(
                        label: 'Description',
                        controller: controller.descriptionController,
                        maxLines: 5
                    ),
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
          child: actionButtons(buttonText, onTap),
        ));
  }

  // Reusable action buttons
  Widget actionButtons(String buttonText, Function onTap) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Add functionality to navigate to application process
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Cancel",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              onTap();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(buttonText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
