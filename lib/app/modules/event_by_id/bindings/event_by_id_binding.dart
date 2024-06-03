import 'package:get/get.dart';

import '../controllers/event_by_id_controller.dart';

class EventByIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventByIdController>(
      () => EventByIdController(),
    );
  }
}
