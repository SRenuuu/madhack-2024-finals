import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/form_dropdown_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/form_text_field.dart';

class SearchFiltersView extends StatelessWidget {
  const SearchFiltersView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      backgroundColor: Colors.white,
      title: const Text('Filter'),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: GetBuilder<HomeController>(
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildIndustryDropdown(controller),
                const SizedBox(height: 24.0),
                buildCategoryDropdown(controller),
                const SizedBox(height: 24.0),
                buildLocationTextField(controller),
                const SizedBox(height: 24.0),
                buildSalaryText(),
                const SizedBox(height: 8.0),
                buildSalaryRangeSlider(controller),
                const SizedBox(height: 16.0),
                buildTagsText(),
                const SizedBox(height: 12.0),
                buildTagsInputChips(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndustryDropdown(HomeController controller) {
    return formDropdownField(
      label: 'Industry',
      items: controller.industries,
      selectedValue: controller.selectedIndustry.value,
      onChanged: (newValue) => controller.changeIndustry(newValue!),
    );
  }

  Widget buildCategoryDropdown(HomeController controller) {
    return Obx(
      () {
        if (controller.selectedIndustry.value != null) {
          final List<String> categories = controller
              .categoriesForIndustry(controller.selectedIndustry.value);
          return formDropdownField(
            label: 'Category',
            items: categories,
            selectedValue: controller.selectedCategory.value,
            onChanged: (newValue) => controller.changeCategory(newValue!),
          );
        } else {
          return const Text('Please select an industry first.');
        }
      },
    );
  }

  Widget buildLocationTextField(HomeController controller) {
    return formTextField(
      label: 'Location',
      hintText: 'Sri Lanka',
      controller: controller.filterLocationController,
      keyboardType: TextInputType.text,
    );
  }

  Widget buildSalaryText() {
    return const Text(
      "Salary",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  Widget buildSalaryRangeSlider(HomeController controller) {
    return Obx(
      () => Column(
        children: [
          RangeSlider(
            values: controller.salaryRange.value,
            min: 0,
            max: 1000000,
            divisions: 20,
            onChanged: (RangeValues values) {
              controller.salaryRange.value = values;
            },
            labels: RangeLabels(
              '\$${NumberFormat.decimalPattern().format(controller.salaryRange.value.start.round())}',
              '\$${NumberFormat.decimalPattern().format(controller.salaryRange.value.end.round())}',
            ),
            activeColor: WorkWiseColors.primaryColor,
          ),
          const SizedBox(height: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Min: ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(controller.salaryRange.value.start.round())} LKR',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Max: ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(controller.salaryRange.value.end.round())} LKR',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTagsText() {
    return const Text(
      "Tags",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  Widget buildTagsInputChips(HomeController controller) {
    return Obx(
      () => Wrap(
        spacing: 10.0,
        children: controller.allTags.map(
          (tag) {
            final isSelected = controller.selectedTags.contains(tag);

            return InputChip(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              label: Text(
                tag,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              backgroundColor: isSelected
                  ? WorkWiseColors.primaryColor
                  : WorkWiseColors.greyColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              deleteIcon: isSelected
                  ? const Icon(Icons.clear, size: 20, color: Colors.white)
                  : null,
              onDeleted: isSelected
                  ? () {
                      controller.removeTag(tag);
                    }
                  : null,
              onPressed: () {
                if (!isSelected) {
                  controller.addTag(tag);
                }
              },
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.white,
      height: 85,
      elevation: 0,
      child: actionButtons(),
    );
  }

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
            child: const Text("Apply Filters",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
