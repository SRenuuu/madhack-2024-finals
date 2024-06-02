import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/organizations/create_event_controller.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../../widgets/form_dropdown_field.dart';
import '../../widgets/form_text_field.dart';

class CreateEventStepOnePage extends StatelessWidget {
  const CreateEventStepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateEventController controller = Get.put(CreateEventController());

    Rx<String?> selectedCause = Rx<String?>(null);
    RxList<String> cause =
        ['Environment Care', 'Animal Welfare', 'Education'].obs;

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
                if (controller.checkStepOne()) {
                  Get.toNamed('/create-event-step-2');
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
                                .blue // Highlight the first dot if it's the current step
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
                    label: 'Event Name',
                    controller: controller.eventNameController,
                    prefixIcon: const Icon(Icons.title,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
                  const SizedBox(height: 24.0),
                  formDropdownField(
                      prefixIcon: const Icon(Icons.ac_unit,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                      label: 'Select Cause',
                      items: cause,
                      selectedValue: selectedCause.value,
                      onChanged: (val) =>
                          {controller.selectedCause.value = val!}),
                  const SizedBox(height: 24.0),
                  formTextField(
                      label: 'Description',
                      controller: controller.descriptionController,
                      maxLines: 5),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            formTextField(
                              label: 'Start Date',
                              controller: controller.startDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: 'YYYY-MM-DD',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today,
                                    size: 20.0,
                                    color: WorkWiseColors.primaryColor),
                                onPressed: () => date(context),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            formTextField(
                              label: 'End Date',
                              controller: controller.endDateController,
                              keyboardType: TextInputType.datetime,
                              hintText: 'YYYY-MM-DD',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today,
                                    size: 20.0,
                                    color: WorkWiseColors.primaryColor),
                                onPressed: () => date(context),
                              ),
                            ),
                            const SizedBox(height: 24.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  formTextField(
                    label: 'Location',
                    keyboardType: TextInputType.text,
                    controller: controller.locationController,
                    prefixIcon: const Icon(Icons.location_on,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
                  const SizedBox(height: 24.0),
                  formTextField(
                    label: 'Telephone Number',
                    keyboardType: TextInputType.phone,
                    controller: controller.telephoneNumberController,
                    prefixIcon: const Icon(Icons.phone,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
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
