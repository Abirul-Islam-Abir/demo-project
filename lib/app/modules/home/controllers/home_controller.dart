import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  wait1Sec() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }
}
