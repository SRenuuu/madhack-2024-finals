import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/organizations/create_event_controller.dart';
import 'package:flutter_app/views/organizations/skills_input.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../../widgets/form_dropdown_field.dart';
import '../../widgets/form_text_field.dart';

class CreateEventStepTwoPage extends StatelessWidget {
  const CreateEventStepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateEventController controller = Get.put(CreateEventController());

    Rx<String?> selectedAgeRestrictions = Rx<String?>(null);
    RxList<String> ageRestrictions = ['18 - 25', '25 - 35', '35 - 45'].obs;

    date(BuildContext context) async {
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

    Widget actionButtons() {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (controller.checkStepTwo()) {
                  Get.toNamed('/create-event-step-3');
                } else {
                  Get.snackbar(
                    'Error',
                    'Please fill all fields',
                    colorText: Colors.white,
                    backgroundColor: Colors.red.shade800.withOpacity(0.9),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: WorkWiseColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Next",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text('Create Event'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Icon(Icons.circle,
                            size: 12,
                            color: Colors
                                .grey // Highlight the first dot if it's the current step
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Icon(
                          size: 12,
                          Icons.circle,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Icon(
                          size: 12,
                          Icons.circle,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  // Editable form
                  formTextField(
                    label: 'Number of Volunteers Required',
                    controller: controller.numOfVolunteerController,
                    prefixIcon: const Icon(Icons.supervisor_account,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
                  const SizedBox(height: 24.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Your Skills',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      SkillsInputField(),
                      // Add other form fields as needed
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  formDropdownField(
                      prefixIcon: const Icon(Icons.sentiment_very_satisfied,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                      label: 'Age Restrictions',
                      items: ageRestrictions,
                      selectedValue: selectedAgeRestrictions.value,
                      onChanged: (val) =>
                          {controller.ageRestrictions.value = val!}),
                  const SizedBox(height: 24.0),
                  formTextField(
                    label: 'Deadline',
                    controller: controller.deadlineController,
                    keyboardType: TextInputType.datetime,
                    hintText: 'YYYY-MM-DD',
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                      onPressed: () => date(context),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  formTextField(
                    label: 'Registration Link',
                    keyboardType: TextInputType.phone,
                    controller: controller.registrationLinkController,
                    prefixIcon: const Icon(Icons.link,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
                  const SizedBox(height: 24.0),
                  formTextField(
                      label: 'Notes',
                      controller: controller.notesController,
                      maxLines: 5),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          height: 85,
          elevation: 0,
          child: actionButtons(),
        ));
  }

  // Reusable action buttons

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
