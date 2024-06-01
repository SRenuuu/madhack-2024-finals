import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:get/get.dart';

import '../../controllers/about_me_controller.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/loading_indicator.dart';

class UserPersonalDetailPage extends StatelessWidget {
  const UserPersonalDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AboutMeController aboutMeController = Get.put(AboutMeController());
    aboutMeController.fetchData();

    selectDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: aboutMeController.dobController.text == ''
            ? DateTime.now()
            : DateTime.parse(aboutMeController.dobController.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      aboutMeController.dobController.text =
          pickedDate != null ? pickedDate.toString().split(' ')[0] : '';
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('About me'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Obx(() =>
              aboutMeController.userDetailsController.isLoading.value
                  ? loadingIndicator() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Editable form
                    formTextField(
                      label: 'Full name',
                      controller: aboutMeController.nameController,
                      prefixIcon: const Icon(Icons.person,
                          size: 20.0, color: WorkWiseColors.primaryColor),
                    ),
                    const SizedBox(height: 24.0),
                    formTextField(
                      label: 'Date of Birth',
                      controller: aboutMeController.dobController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'YYYY-MM-DD',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today,
                            size: 20.0, color: WorkWiseColors.primaryColor),
                        onPressed: () => selectDate(context),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    formTextField(
                        label: 'Email',
                        prefixIcon: const Icon(Icons.email,
                            size: 20.0, color: WorkWiseColors.primaryColor),
                        controller: aboutMeController.emailController,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 24.0),
                    formTextField(
                        label: 'Phone',
                        controller: aboutMeController.phoneController,
                        prefixIcon: const Icon(Icons.phone,
                            size: 20.0, color: WorkWiseColors.primaryColor),
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 24.0),
                    const Text(
                      "Links",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    Obx(() => ListView.builder(
                          itemCount: aboutMeController.textFieldControllers.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                formTextField(
                                    showLabel: false,
                                    label: '',
                                    prefixIcon: const Icon(Icons.link_outlined,
                                        size: 22.0,
                                        color: WorkWiseColors.primaryColor),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline,
                                          size: 24.0,
                                          color: WorkWiseColors.darkGreyColor),
                                      onPressed: () =>
                                          aboutMeController.removeTextField(index),
                                    ),
                                    controller:
                                        aboutMeController.textFieldControllers[index],
                                    keyboardType: TextInputType.url),
                                const SizedBox(height: 8.0)
                              ],
                            );
                          },
                        )),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () => aboutMeController.addTextField(),
                        label: const Text('Add Link',
                            style: TextStyle(
                                color: WorkWiseColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                        ),
                        icon: const Icon(Icons.add_circle),
                      ),
                    ),

                    // buildMobileNumberField("+94", "+773766397", null, null),
                    // const SizedBox(height: 16.0),
                    //
                    // // Links section
                    // const Text(
                    //   'Links',
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Column(
                    //   children: [
                    //     ...["Hello", "world"].map((link) => buildLink(link, addLink)),
                    //   ],
                    // ),
                    // ElevatedButton.icon(
                    //   onPressed: () => addLink(''),
                    //   label: const Text('Add Link'),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.white12,
                    //   ),
                    //   icon: const Icon(CupertinoIcons.add_circled_solid),
                    // ),
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
          child: actionButtons(aboutMeController.updateUserData, () => print('x')),
        ));
  }

  // Reusable action buttons
  Widget actionButtons(Function onUpdate, Function onCancel) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              onCancel();
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
              onUpdate();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: WorkWiseColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Update",
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
