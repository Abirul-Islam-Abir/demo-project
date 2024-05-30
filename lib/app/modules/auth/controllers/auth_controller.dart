import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/data/token_keeper.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());

  // RxBool isPasskeySupported = false.obs;

  final emailController = TextEditingController();
  RxBool isVerified = true.obs;
  RxBool isLoading = false.obs;
  Future<void> verifyPassKey(String email) async {
    // late bool isApiResponseSuccess;
    isLoading.value = true;
    update();
    String pass = '';
    final url1 = Uri.parse(
        'https://kumele-backend.vercel.app/api/auth/passkey/generate/challenge');
    final url2 = Uri.parse(
        'https://kumele-backend.vercel.app/api/auth/passkey/verify/challenge');

    http.post(url1, body: {"email": email}).then((response) {
      log(response.body);
      pass = jsonDecode(response.body)['data']['passkey_challenge'];
    }).then((value) {
      return http.post(url2, body: {
        "email": email,
        "key": pass,
      }).then((response) {
        log(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          log('saving token');
          TokenKeeper.setTokens(
            responseData['data']['token'],
            responseData['data']['user']['full_name'],
            responseData['data']['user']['email'],
          ).then((value) {
            isVerified.value = true;
            if (isVerified.value) {
              Get.offAllNamed(Routes.HOME);
            } else {
              Get.showSnackbar(const GetSnackBar(
                message: 'Please verify your email',
                duration: Duration(seconds: 2),
              ));
              Get.offAllNamed(Routes.LOGIN_SELECT);
            }
          });
          isLoading.value = false;
          update();
          // isApiResponseSuccess = true;
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Please verify your email1',
            duration: Duration(seconds: 2),
          ));
          isVerified.value = false;
          // isApiResponseSuccess = false;
        }
        isLoading.value = false;
        update();
      });
    });
  }

  RxBool isAuthenticate = false.obs;

  onSignInPressed() async {
    await verifyPassKey(emailController.text.trim());
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
