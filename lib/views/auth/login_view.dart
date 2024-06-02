import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_data_model.dart';
import 'package:get/get.dart';

import '../../services/firebase_auth_service.dart';
import '../../controllers/login_controller.dart';
import '../../theme/colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8.0), // Spacer
                    // Logo
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/images/workwise-logo.png',
                        width: 170.0,
                      ),
                    ),
                    const Text("Welcome back!",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4.0), // Spacer
                    const Text("Please sign in to continue",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: WorkWiseColors.darkGreyColor)),
                    const SizedBox(height: 40.0),
                    // Email Field
                    TextField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 24.0), // Spacer
                    // Password Field
                    TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 8.0), // Spacer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Forgot Password button pressed');
                          },
                          child: const Text('Forgot Password?',
                              style: TextStyle(
                                  color: WorkWiseColors.primaryColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0), // Spacer
                    // Sign In Button
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.isLoginLoading.value
                            ? null // Disable the button if login is in progress
                            : () async {
                                // Make the function async to allow fetching user role
                                FocusScope.of(context)
                                    .unfocus(); // Dismiss keyboard
                                UserData? loginResult = await controller
                                    .login(); // Attempt to log in

                                if (loginResult != null) {
                                  String? userRole = loginResult.role;

                                  if (userRole == "volunteer") {
                                    Get.snackbar(
                                      icon: const Icon(
                                        Icons.check_circle,
                                        size: 26,
                                        color: Colors.white,
                                      ),
                                      shouldIconPulse: true,
                                      "Success",
                                      "Welcome back Volunteer!",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.green.shade700
                                          .withOpacity(0.9),
                                    );
                                    Get.offAllNamed("/home");
                                  } else if (userRole == "organizer") {
                                    Get.snackbar(
                                      icon: const Icon(
                                        Icons.check_circle,
                                        size: 26,
                                        color: Colors.white,
                                      ),
                                      shouldIconPulse: true,
                                      "Success",
                                      "Welcome back Organizer!",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.green.shade700
                                          .withOpacity(0.9),
                                    );
                                    Get.offAllNamed("/organizer-home");
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Invalid user role",
                                      colorText: Colors.white,
                                      backgroundColor:
                                          Colors.red.shade700.withOpacity(0.9),
                                    );
                                  }
                                }
                              },
                        child: !controller.isLoginLoading.value
                            ? const Text(
                                'Sign in') // Show 'Sign in' text when not loading
                            : const SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: CircularProgressIndicator(
                                    strokeWidth:
                                        2.0), // Show loading indicator when loading
                              ),
                      ),
                    ),
                    const SizedBox(height: 24.0), // Spacer
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        print('Sign in With Google button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: WorkWiseColors.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            width: 24.0,
                            height: 24.0,
                          ),
                          const SizedBox(width: 8.0), // Spacer
                          const Text('Sign in With Google'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0), // Spacer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.toNamed("/sign_up");
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  color: WorkWiseColors.primaryColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0), // Spacer
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
