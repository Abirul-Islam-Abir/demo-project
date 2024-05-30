import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/data/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<bool> signIn() async {
    isLoading.value = true;
    update();
    final url = Uri.parse(Urls.signInUrl);
    final data = {
      "email": emailController.text,
      "password": passwordController.text
    };
    final res = await http.post(url, body: data);
    isLoading.value = false;
    update();
    log(data.toString());
    log(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final responseData = jsonDecode(res.body);
      log('saving token');
      TokenKeeper.setTokens(
        responseData['data']['response']['token'],
      );
      Get.showSnackbar(const GetSnackBar(
        message: 'Login successful',
        duration: Duration(seconds: 2),
      ));
      return true;
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Login failed',
        duration: Duration(seconds: 2),
      ));
      return false;
    }
  }
}
