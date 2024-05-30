import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.emailController.text = 'muj.i@icloud.com';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Obx(
                () => controller.isLoading.value || controller.isLoading2.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          final isGotToken = await AuthController.to
                              .verifyPassKey(
                                  controller.emailController.text.trim());
                          if (isGotToken) {
                            Get.offAllNamed(Routes.HOME);
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              message: 'Please verify your email',
                              duration: Duration(seconds: 2),
                            ));
                            Get.offAllNamed(Routes.AUTH);
                          }
                        },
                        child: const Text('Sign In'),
                      ),
              ),
              const SizedBox(height: 10),
              const Text('Don\'t have an account?'),
              TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.SIGNUP);
                  },
                  child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
