import 'dart:convert';

import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/model/all_events_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetAllEventController extends GetxController {
  static GetAllEventController to = Get.put(GetAllEventController());
  RxBool isLoading = true.obs;
  List<AllEventModel> allEventsData = [];

  Future<void> allEvents() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      isLoading.value = true;
      update();
      var response = await http.get(
        Uri.parse(ApiServices.getAllEventsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var json in responseData['data']['events']) {
          allEventsData.add(AllEventModel.fromJson(json));
        }
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
        // Handle error
      }
    }
  }
}
