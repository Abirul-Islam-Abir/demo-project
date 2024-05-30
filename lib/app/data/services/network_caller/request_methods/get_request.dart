import 'dart:developer';
import 'dart:io';

import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/data/services/network_caller/network_response.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

class GetRequest {
  static Dio dio = Dio();

  static Future<NetworkResponse> execute(String url) async {
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${TokenKeeper.accessToken.toString()}'
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(true, response.statusCode!, response.data);
      } else {
        log(response.statusCode.toString());
        return NetworkResponse(false, response.statusCode!, null);
      }
    } catch (e) {
      //  dio errors handle
      if (e is DioException && e.response?.statusCode == 401) {
        log(e.response!.statusCode.toString());
        TokenKeeper.clear();
        Get.offAllNamed(Routes.LOGIN_SELECT);
        return NetworkResponse(false, e.response!.statusCode!, null);
      } else if (e is DioException && e.response?.statusCode == 404) {
        log(e.response!.statusCode.toString());
        TokenKeeper.clear();
        Get.offAllNamed(Routes.LOGIN_SELECT);
        return NetworkResponse(false, e.response!.statusCode!, null);
      } else if (e is DioException && e.error is SocketException) {
        log(e.response!.statusCode.toString());
        TokenKeeper.clear();
        Get.offAllNamed(Routes.LOGIN_SELECT);
        return NetworkResponse(false, e.response!.statusCode!, null);
      } else {
        log(e.toString());
        return NetworkResponse(false, -1, null);
      }
    }
  }
}
