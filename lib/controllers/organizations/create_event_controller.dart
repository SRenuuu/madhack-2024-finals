import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateEventController extends GetxController {
  final TextEditingController eventNameController = TextEditingController();
  final RxString selectedCause = RxString('');
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController telephoneNumberController =
      TextEditingController();

  // Step 2
  final TextEditingController numOfVolunteerController =
      TextEditingController();
  final RxString ageRestrictions = RxString('');
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController registrationLinkController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  var textFieldControllers =
      List<TextEditingController>.empty(growable: true).obs;

  RxList<String> selectedSkills = <String>[].obs;
  RxList<String> selectedImages = <String>[].obs;
  RxString uploadedImageUrl = ''.obs;

  void addSkill(String skill) {
    if (!selectedSkills.contains(skill)) {
      selectedSkills.add(skill);
    }
  }

  void removeSkill(String skill) {
    selectedSkills.remove(skill);
  }

  RxList<String> selectedTag = <String>[].obs;

  void addTag(String tag) {
    if (!selectedTag.contains(tag)) {
      selectedTag.add(tag);
    }
  }

  void removeTag(String tag) {
    selectedTag.remove(tag);
  }

  bool checkStepOne() {
    if (eventNameController.text.isEmpty ||
        selectedCause.value.isEmpty ||
        descriptionController.text.isEmpty ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        locationController.text.isEmpty ||
        telephoneNumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  bool checkStepTwo() {
    if (numOfVolunteerController.text.isEmpty ||
        ageRestrictions.value.isEmpty ||
        deadlineController.text.isEmpty ||
        registrationLinkController.text.isEmpty ||
        notesController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File image = File(imagePath);
    final reference =
        _storage.ref().child("images/${DateTime.now().millisecondsSinceEpoch}");
    final uploadTask = reference.putFile(image);
    final imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  Future<bool> handleCreateEvent() async {
    if (selectedImages.isNotEmpty) {
      try {
        uploadedImageUrl.value =
            await uploadImageToFirebaseStorage(selectedImages[0]);

        CreateEventDTO createEventDTO = CreateEventDTO(
          eventName: eventNameController.text,
          selectedCause: selectedCause.value,
          description: descriptionController.text,
          startDate: startDateController.text,
          endDate: endDateController.text,
          location: locationController.text,
          telephoneNumber: telephoneNumberController.text,
          numOfVolunteer: numOfVolunteerController.text,
          ageRestrictions: ageRestrictions.value,
          deadline: deadlineController.text,
          registrationLink: registrationLinkController.text,
          notes: notesController.text,
          selectedSkills: selectedSkills,
          selectedTag: selectedTag,
          uploadedImageUrl: uploadedImageUrl.value,
        );

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference events = firestore.collection('events');
        DocumentReference documentRef = await events.add({
          'applied_count': 0,
          'deadline':
              Timestamp.fromDate(DateTime.parse(createEventDTO.deadline)),
          'description': createEventDTO.description,
          'email': 'sandul@gmail.com',
          'end_date':
              Timestamp.fromDate(DateTime.parse(createEventDTO.endDate)),
          'image': createEventDTO.uploadedImageUrl,
          'is_featured': true,
          'location': createEventDTO.location,
          'name': createEventDTO.eventName,
          'notes': createEventDTO.notes,
          'organizer_email': 'sandul@gmail.com',
          'organizer_phone': createEventDTO.telephoneNumber,
          'registration_link': createEventDTO.registrationLink,
          'skills': createEventDTO.selectedSkills,
          'start_date':
              Timestamp.fromDate(DateTime.parse(createEventDTO.startDate)),
          'tags': createEventDTO.selectedTag,
        });

        print('Document ID: ${documentRef.id}');
        return true;
      } catch (e) {
        print('Error creating event: $e');
        return false;
      }
    } else {
      print('No image selected');
      return false;
    }
  }
}

class CreateEventDTO {
  final String eventName;
  final String selectedCause;
  final String description;
  final String startDate;
  final String endDate;
  final String location;
  final String telephoneNumber;
  final String numOfVolunteer;
  final String ageRestrictions;
  final String deadline;
  final String registrationLink;
  final String notes;
  final List<String> selectedSkills;
  final List<String> selectedTag;
  final String uploadedImageUrl;

  CreateEventDTO({
    required this.eventName,
    required this.selectedCause,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.telephoneNumber,
    required this.numOfVolunteer,
    required this.ageRestrictions,
    required this.deadline,
    required this.registrationLink,
    required this.notes,
    required this.selectedSkills,
    required this.selectedTag,
    required this.uploadedImageUrl,
  });

  @override
  String toString() {
    return 'CreateEventDTO{eventName: $eventName, selectedCause: $selectedCause, description: $description, startDate: $startDate, endDate: $endDate, location: $location, telephoneNumber: $telephoneNumber, numOfVolunteer: $numOfVolunteer, ageRestrictions: $ageRestrictions, deadline: $deadline, registrationLink: $registrationLink, notes: $notes, selectedSkills: $selectedSkills, selectedTag: $selectedTag, uploadedImageUrl: $uploadedImageUrl}';
  }
}
