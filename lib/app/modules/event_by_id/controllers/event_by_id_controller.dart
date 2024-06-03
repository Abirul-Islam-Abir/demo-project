import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/token_keeper.dart';
import '../../../data/urls/urls.dart';
import 'package:http/http.dart' as http;

class EventByIdController extends GetxController {
  //TODO: Implement EventByIdController
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  Map eventByIdData = {};
  Map createChatData = {};
  List chatEventByIdData = [];
  final id = Get.arguments;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> eventById() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      update();
      var response = await http.get(
        Uri.parse(Urls.eventByIdUrl + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        eventByIdData = responseData['data']['event'];
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        // Handle error
      }
    }
  }

  Future<void> chatByEventId() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      update();
      var response = await http.get(
        Uri.parse(Urls.chatByEventId + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        chatEventByIdData = responseData;
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        // Handle error
      }
    }
  }

  Future<void> createChat() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      update();
      var body = jsonEncode({"event_id": id});
      var response = await http.post(Uri.parse(Urls.createChat),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
      var responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 201) {
        createChatData = responseData;
        await chatByEventId();
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
        // Handle error
      }
    }
  }

  Future<void> updateData() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      update();
      var body = {
        "title": title.text,
        "description": desc.text,
        "eventCategoryId": "7dc7cd92-36a8-4c8a-80c2-613fe758dd70",
        "image_url":
            "http://res.cloudinary.com/doz2bhhqv/image/upload/v1705300939/1705300934_event_image.png",
        "min_age": 12,
        "max_age": 40,
        "Guest_limit": 24,
        "escrow_price": 100,
        "cash_price": 0,
        "payment_type": "escrow_paypal",
        "start_time": "2024-01-14T23:59:59Z",
        "end_time": "2024-01-15T00:00:00Z"
      };
      var response = await http.put(Uri.parse(Urls.eventUpdateUrl + id),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        eventByIdData = responseData['data']['updatedEvent'];
        await eventById();
        title.clear();
      }
    }
  }

  Future<void> delete() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      update();
      var response = await http.delete(
        Uri.parse(Urls.eventDeleteUrl + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Success', 'Deleted Sucess');
      } else {
        Get.back();
        Get.snackbar('Error', 'Server error');
      }
    }
  }

  @override
  void onInit() {
    eventById();
    chatByEventId();

    super.onInit();
  }
}
