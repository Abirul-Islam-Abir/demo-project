import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final isSuccess = await controller.signIn();
                              if (isSuccess) {
                                Get.offAllNamed(Routes.HOME);
                              }
                            },
                            child: const Text('Sign In'),
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
            ],
          ),
        ),
      ),
    );
  }
}
