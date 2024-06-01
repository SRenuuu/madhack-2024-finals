import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/qualification_controller.dart';
import '../../theme/colors.dart';
import '../../widgets/form_text_field.dart';

class QualificationPage extends StatelessWidget {
  const QualificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    QualificationController controller = Get.put(QualificationController());

    date(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.dateController.text == ''
            ? DateTime.now()
            : DateTime.parse(controller.dateController.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      controller.dateController.text =
      pickedDate != null ? pickedDate.toString().split(' ')[0] : '';
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Add Qualification'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Editable form
                  formTextField(
                    label: 'Qualification',
                    controller: controller.qualificationController,
                    prefixIcon: const Icon(Icons.format_list_bulleted,
                        size: 20.0, color: WorkWiseColors.primaryColor),
                  ),
                  const SizedBox(height: 24.0),
                  formTextField(
                    label: 'Start Date',
                    controller: controller.dateController,
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
                      label: 'Description',
                      controller: controller.descriptionController,
                      maxLines: 5
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
  Widget actionButtons() {
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
              // Add functionality to navigate to application process
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Add",
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
