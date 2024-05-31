import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_select_controller.dart';

class LoginSelectView extends GetView<LoginSelectController> {
  const LoginSelectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        title: const Text('Select Login Method'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.AUTH);
                  },
                  child: const Text('Login with Email & Passkey')),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: const Text('Login with Email & Password')),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: const Text('Sign Up with Email & Password')),
            ],
          ),
        ),
      ),
    );
  }
}
