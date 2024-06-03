import 'package:get/get.dart';

import '../controllers/all_messages_by_chat_id_controller.dart';

class AllMessagesByChatIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllMessagesByChatIdController>(
      () => AllMessagesByChatIdController(),
    );
  }
}
