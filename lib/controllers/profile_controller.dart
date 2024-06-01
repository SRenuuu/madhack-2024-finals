import 'package:get/get.dart';

import '../services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
}
