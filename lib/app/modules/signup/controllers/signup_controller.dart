import 'dart:convert';

import 'package:demo/app/modules/auth/controllers/auth_controller.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signUp() async {
    isLoading.value = true;
    update();
    final String fullName = fullNameController.text;
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    Map<String, dynamic> data = {
      'full_name': fullName,
      'email': email,
      'gender': 'Male',
      "dob": "2011-01-07T16:41:01.919Z",
      'password': password,
      'confirm_password': confirmPassword,
      "referral_code": "12345336",
      "street": "3",
      "town": "khulna",
      "city": "khulna",
      "state": "khulna",
      'country': 'Bangladesh',
      "interests": ["036c8983-4c11-43b6-82b0-8701df609cbf"]
    };
    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(ApiServices.signUpUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    var responseData = json.decode(response.body);
    if (response.statusCode == 201) {
      isLoading.value = false;
      update();
      Get.showSnackbar(GetSnackBar(
        message: responseData['message'],
        duration: const Duration(seconds: 2),
      ));
      final isGotToken = await AuthController.to.verifyPassKey(email);
      if (isGotToken) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: 'Please verify your email',
          duration: Duration(seconds: 2),
        ));
        Get.offAllNamed(Routes.AUTH);
      }
    } else {
      isLoading.value = false;
      update();
      Get.showSnackbar(GetSnackBar(
        message: responseData['message'],
        duration: const Duration(seconds: 2),
      ));
      // Handle error
    }
  }
}