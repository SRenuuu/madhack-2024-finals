import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // Optional for location permission

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  // Optional location permission handling
  final Location _location = Location();

  Future<bool> _checkLocationPermission() async {
    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  @override
  void initState() {
    super.initState();
    // Get current location (optional)
    _getLocation();
  }

  Future<void> _getLocation() async {
    if (await _checkLocationPermission()) {
      var locationData = await _location.getLocation();
      selectedLocation.value =
          LatLng(locationData.latitude!, locationData.longitude!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Location'),
      ),
      body: Column(
        children: [
          // Search bar (optional)
          // SearchWidget(
          //   hintText: 'Search locations...',
          //   searchTerm: _searchController.text,
          //   onChanged: (value) => _searchController.text = value,
          //   onSubmitted: (String query) {
          //     // Handle search query here (e.g., call Google Places API)
          //     print('Search query: $query');
          //   },
          // ),
          const SizedBox(height: 10.0),
          // Text field for manual input
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter location (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Selected location display
          if (selectedLocation.value != null)
            Text(
                'Selected Location: ${selectedLocation.value!.latitude}, ${selectedLocation.value!.longitude}'),
          const SizedBox(height: 10.0),
          // Button to integrate with your stepper (replace with your navigation logic)
          ElevatedButton(
            onPressed: () {
              // Navigate to next step in your stepper
              // Get.to(YourNextStepScreen(selectedLocation: selectedLocation.value));
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
