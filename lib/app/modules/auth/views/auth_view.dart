import 'dart:developer';

import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.emailController.text = 'muj.i@icloud.com';
    final LocalAuthentication auth = LocalAuthentication();

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
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value || controller.isLoading2.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (!controller.isAuthenticate.value) {
                                final bool canCheckBiometrics =
                                    await auth.canCheckBiometrics;
                                if (canCheckBiometrics) {
                                  try {
                                    final bool didAuthenticate =
                                        await auth.authenticate(
                                      localizedReason:
                                          'Please authenticate to sign in',
                                      options: const AuthenticationOptions(
                                        biometricOnly: false,
                                      ),
                                    );
                                    controller.isAuthenticate.value =
                                        didAuthenticate;
                                    if (didAuthenticate) {
                                      controller.onSignInPressed();
                                    } else {
                                      Get.showSnackbar(const GetSnackBar(
                                        message: 'Authentication failed',
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                }
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
