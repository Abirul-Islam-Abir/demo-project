import 'package:demo/app/modules/auth/controllers/auth_controller.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller.fullNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return controller.isLoading.value ||
                        AuthController.to.isLoading.value ||
                        AuthController.to.isLoading2.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: controller.signUp,
                        child: const Text('Sign Up'),
                      );
              }),
              const Text('Already have an account?'),
              TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.AUTH);
                  },
                  child: const Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
