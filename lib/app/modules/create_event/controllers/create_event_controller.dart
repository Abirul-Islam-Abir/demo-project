import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/common/widgets/multiple_image_select/multiple_image_select_controller.dart';
import 'package:demo/app/data/urls/urls.dart';
import 'package:demo/app/modules/get_all_events/get_all_events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateEventController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final guestLimitController = TextEditingController();
  final cashPriceController = TextEditingController();
  final imageUrl = MultipleImageSelectController.instance.imageUrl;
  RxBool isLoading = false.obs;
  Future<bool> createEvent() async {
    isLoading.value = true;
    update();
    final url = Uri.parse(Urls.eventCreateUrl);
    final data = {
      "title": titleController.text.toString(),
      "description": descriptionController.text.toString(),
      "eventCategoryId": "7dc7cd92-36a8-4c8a-80c2-613fe758dd70",
      "image_url": imageUrl,
      "min_age": 12,
      "max_age": 24,
      "Guest_limit": int.parse(guestLimitController.text),
      "escrow_price": 100,
      "cash_price": int.parse(cashPriceController.text),
      "payment_type": "escrow_paypal",
      "start_time": "2024-01-14T23:59:59Z",
      "end_time": "2024-01-15T00:00:00Z"
    };
    final String? token = TokenKeeper.accessToken;
    // if (token != null && token.isNotEmpty) {
    log(token.toString());
    final res = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      log(res.body);
      Get.back();
      GetAllEventController.to.allEvents();
      isLoading.value = false;
      update();
      return true;
    } else {
      log(res.body);
      Get.snackbar(
        'Event creation failed',
        '',
      );
      isLoading.value = false;
      update();
      return false;
    }
  }
}
