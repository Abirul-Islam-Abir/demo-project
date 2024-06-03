import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.emailController.text = 'muj.i@icloud.com';
    final LocalAuthentication auth = LocalAuthentication();

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.type == 'login'
            ? 'Login With Passkey'
            : 'Sign Up With Passkey'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
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
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
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
                        child: Text(
                            controller.type == 'login' ? 'Login' : 'Signup'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
