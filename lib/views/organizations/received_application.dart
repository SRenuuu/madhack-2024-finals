import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/organizations/create_event_controller.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class ReceivedApplication extends StatelessWidget {
  const ReceivedApplication({super.key});

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
        title: const Text('Manage Applications'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Received',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: WorkWiseColors.primaryColor,
                      ),
                    ),
                    Text(
                      'Applications',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                buildApplicationRow(
                  'John Doe',
                  'sandul@gmail.com',
                  '+94771234567',
                  'Received',
                  (value) => {},
                  (value) => {},
                  (value) => {},
                  (value) => {},
                ),
                buildApplicationRow(
                  'John Doe',
                  'sandul@gmail.com',
                  '+94771234567',
                  'Received',
                  (value) => {},
                  (value) => {},
                  (value) => {},
                  (value) => {},
                ),
                buildApplicationRow(
                  'John Doe',
                  'sandul@gmail.com',
                  '+94771234567',
                  'Received',
                  (value) => {},
                  (value) => {},
                  (value) => {},
                  (value) => {},
                ),
                // Editable form
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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

  Widget buildApplicationRow(
    String name,
    String email,
    String mobile,
    String status,
    void Function(String?)? onNameChange,
    void Function(String?)? onEmailChange,
    void Function(String?)? onMobileChange,
    void Function(String?)? onStatusChange,
  ) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
              radius: 25,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    mobile,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              status,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // add a divider
        const Divider(),
      ],
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
