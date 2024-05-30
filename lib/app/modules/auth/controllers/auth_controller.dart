import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/data/token_keeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  RxBool isPasskeySupported = false.obs;

  RxBool isLoading2 = false.obs;

  Future<bool> verifyPassKey() async {
    await generatePassKey(emailController.text);
    isLoading2.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {
      "attestationData":
          "I2NzRiMmEzYS1mMzgzLTRiNDYtYmMzMi0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYy",
      "authentication": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOi",
      "clientData": "RzdLKcV94edLdBN5t1w1_f67PKKPrUUEM-iTiFfQ",
      "credentials": {
        "algorithm": "RS256",
        "id": "0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYyMjE"
      },
      "email": emailController.text,
      "key": passKeyController.text
    };

    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      headers: {
        'Content-Type': 'application/json', // Define the content type as JSON
      },
    );
    final responseData = jsonDecode(response.body);
    TokenKeeper.setTokens(responseData['data']['token']);
    if (response.statusCode == 200) {
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

  Future<bool> generatePassKey(String email) async {
    isLoading.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {"email": emailController.text};

    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      headers: {
        'Content-Type': 'application/json', // Define the content type as JSON
      },
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      update();

      log(responseData.toString());
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => VerifyPassKeyScreen(
      //       mail: _emailController.text,
      //       passKeyChallenge: responseData['data']['passkey_challenge']),
      // ));
      passKeyController.text = responseData['data']['passkey_challenge'];
      return true;
    } else {
      isLoading.value = false;
      update();
      return false;
      // Request failed with an error status code, handle the error
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
}
