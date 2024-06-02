import 'package:flutter_app/services/firebase_auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuthService authService = Get.find<FirebaseAuthService>();

  // create a reactive strings to hold user data for email and name
  RxString email = ''.obs;
  RxString name = ''.obs;

  // fetch email and name from the AuthService
  @override
  Future<void> onInit() async {
    email.value = await authService.getEmail() ?? '';
    name.value = await authService.getName() ?? '';
    super.onInit();
  }
}
