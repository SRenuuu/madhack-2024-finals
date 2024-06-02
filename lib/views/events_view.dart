import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/widgets/search_with_filter.dart';
import 'package:get/get.dart';

import '../models/event_posting_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/event_card.dart';
import 'home/home_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    // Mock data for job postings
    List<EventPosting> jobPostings = [];

    return AdvancedDrawer(
      controller: controller.drawerController,
      drawer: CustomDrawer(),
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the row content
              children: [
                SizedBox(
                  width: 24,
                  child: GestureDetector(
                    child: const Icon(Icons.menu),
                    onTap: controller.handleDrawerToggle,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Events',
                    textAlign: TextAlign.center, // Center the text within Flexible
                  ),
                ),
                const SizedBox(
                  width: 24,
                  child: null,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // searchBarWithFilterIcon(
                //   searchController: TextEditingController(),
                //   colour: WorkWiseColors.primaryColor,
                //   onFilterPressed: () {
                //     // Handle filter icon press
                //   },
                // ),
                // const SizedBox(height: 15.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.yourEvents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: EventCard(
                        shadowColor:
                        WorkWiseColors.greyColor.withOpacity(0.5),
                        onCardTap: () => Get.toNamed("/event",
                            arguments:
                            CustomArg(controller.yourEvents[index].id)),
                        eventPosting: controller.yourEvents[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
