import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  navigateByState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (TokenKeeper.accessToken == null) {
        Get.offAllNamed(Routes.LOGIN_SELECT);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  @override
  void onInit() {
    TokenKeeper.getTokens();
    navigateByState();
    super.onInit();
  }
}
