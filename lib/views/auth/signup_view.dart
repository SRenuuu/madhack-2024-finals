import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/signup_controller.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());

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
                    // // Logo
                    // Padding(
                    //   padding: const EdgeInsets.all(4.0),
                    //   child: Image.asset(
                    //     'assets/images/workwise-logo.png',
                    //     width: 170.0,
                    //   ),
                    // ),
                    const Text("Create an Account",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 30.0),
                    // Name Field
                    TextField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 24.0),
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
                    // Password Field
                    const SizedBox(height: 24.0),
                    TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                    ),
                    const SizedBox(height: 8.0), // Spacer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Forgot Password button pressed');
                            Get.toNamed("/employer_sign_up");
                          },
                          child: const Text('Are you an employer?',
                              style: TextStyle(
                                  color: WorkWiseColors.primaryColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0), // Spacer
                    // Sign In Button
                    Obx(
                      () => ElevatedButton(
                          onPressed: controller.isRegisterLoading.value
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  controller.register().then((value) {
                                    if (value) {
                                      Get.offAllNamed("/sign_up");
                                      Get.snackbar(
                                        icon: const Icon(
                                          Icons.check_circle,
                                          size: 26,
                                          color: Colors.white,
                                        ),
                                        shouldIconPulse: true,
                                        "Success",
                                        "Welcome to WorkWise",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.green.shade700
                                            .withOpacity(0.9),
                                      );
                                      Get.toNamed("/login");
                                    }
                                  });
                                },
                          child: !controller.isRegisterLoading.value
                              ? const Text('Sign Up')
                              : const SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0),
                                )),
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
                    const SizedBox(height: 16.0), // Spacer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () {
                            print('Sign Up button pressed');
                            Get.toNamed("/login");
                          },
                          child: const Text('Sign In',
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
