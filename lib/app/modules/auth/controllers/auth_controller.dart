import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/data/token_keeper.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());

  RxBool isPasskeySupported = false.obs;

  RxBool isLoading2 = false.obs;

  Future<bool> verifyPassKey(String email) async {
    await generatePassKey();
    isLoading2.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.verifyPassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {
      // "attestationData":
      //     "I2NzRiMmEzYS1mMzgzLTRiNDYtYmMzMi0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYy",
      // "authentication": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOi",
      // "clientData": "RzdLKcV94edLdBN5t1w1_f67PKKPrUUEM-iTiFfQ",
      // "credentials": {
      //   "algorithm": "RS256",
      //   "id": "0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYyMjE"
      // },
      "email": email,
      "key": passKeyController.text.trim(),
    };
    log('Response data: $data');
    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      // headers: {
      //   'Content-Type': 'application/json', // Define the content type as JSON
      // },
    );
// Print the raw response body for debugging
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

// Decode the response body
    final responseData = jsonDecode(response.body);
    log(responseData.toString());
    if (response.statusCode == 200) {
      log(responseData['data']['user']['full_name']);
      TokenKeeper.setTokens(
        responseData['data']['token'],
        responseData['data']['user']['full_name'],
        responseData['data']['user']['email'],
      );

      isLoading2.value = false;
      update();
      log(response.body);
      return true;
    } else {
      isLoading2.value = false;
      update();
      // Request failed with an error status code, handle the error

      return false;
    }
  }

  final emailController = TextEditingController();

  final TextEditingController passKeyController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<bool> generatePassKey() async {
    isLoading.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {"email": emailController.text.trim()};

    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      // headers: {
      //   'Content-Type': 'application/json', // Define the content type as JSON
      // },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      isLoading.value = false;
      update();

      log(responseData.toString());

      passKeyController.text = responseData['data']['passkey_challenge'];
      return true;
    } else {
      isLoading.value = false;
      update();
      return false;
      // Request failed with an error status code, handle the error
    }
  }

  RxBool isAuthenticate = false.obs;

  onSignInPressed() async {
    final isGotToken = await verifyPassKey(emailController.text.trim());
    if (isGotToken) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Please verify your email',
        duration: Duration(seconds: 2),
      ));
      Get.offAllNamed(Routes.AUTH);
    }
  }
}

abstract class ApiServices {
  static const String _baseUrl = 'https://kumele-backend.vercel.app/api';
  static String signUpUrl = '$_baseUrl/auth/signup';
  static String signInUrl = '$_baseUrl/auth/login';
  static String getUserDataUrl = '$_baseUrl/auth/getUserData';
  static String generatePassKeyUrl =
      '$_baseUrl/auth/passkey/generate/challenge';
  static String verifyPassKeyUrl = '$_baseUrl/auth/passkey/verify/challenge';
  static String getUser = '$_baseUrl/user/get_user';
}
