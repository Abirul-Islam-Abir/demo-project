import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/token_keeper.dart';
import 'package:http/http.dart' as http;

import '../../../data/urls/urls.dart';

class AllMessagesByChatIdController extends GetxController {
  List allMessagesData = [];
  final chatId = Get.arguments['chatId'];
  final eventId = Get.arguments['event_id'];
  final messageController = TextEditingController();
  final updateController = TextEditingController();

  Future<void> createChat() async {
    allMessagesData.add({
      "messageBody": messageController.text.toString(),
      "event_id": eventId.toString(),
      "chatId": chatId.toString()
    });
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      update();
      var body = jsonEncode({
        "messageBody": messageController.text.toString(),
        "event_id": eventId.toString(),
        "chatId": chatId.toString()
      });
      var response = await http.post(Uri.parse(Urls.createMessage),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
      messageController.clear();
      var responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        print(responseData);
        update();
        // await allMessageByChatId();
      } else {
        update();
        // Handle error
      }
    }
  }

  Future<void> allMessageByChatId() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      update();
      var response = await http.get(
        Uri.parse(Urls.allMessagesByChatId + chatId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        allMessagesData = responseData['chatMessages'];
        update();
      } else {
        update();
        // Handle error
      }
    }
  }

  Future<void> updateMessage({required String id}) async {
    Get.back();
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      // Optimistic update: update the message in the list before the API call
      int index = allMessagesData.indexWhere((message) => message['id'].toString() == id);
      if (index != -1) {
        allMessagesData[index]['messageBody'] = updateController.text.toString();
        update();
      }

      var body = jsonEncode({"messageBody": updateController.text.toString()});
      var response = await http.put(
        Uri.parse(Urls.updateMessage + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {

        update();
      } else {

      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    allMessageByChatId();
    print(eventId + 'event');
    print(chatId + 'chat');
    super.onInit();
  }
}
