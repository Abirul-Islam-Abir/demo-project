import 'package:get/get.dart';

import '../controllers/login_select_controller.dart';

class LoginSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginSelectController>(
      () => LoginSelectController(),
    );
  }
}
