import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_messages_by_chat_id_controller.dart';

class AllMessagesByChatIdView extends GetView<AllMessagesByChatIdController> {
  AllMessagesByChatIdView({Key? key}) : super(key: key);
  final controller = Get.put(AllMessagesByChatIdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllMessagesByChatIdView'),
        centerTitle: true,
      ),
      body: GetBuilder<AllMessagesByChatIdController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: controller.allMessagesData.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    controller.setMessage(controller.allMessagesData[index]
                            ['messageBody']
                        .toString());
                  },
                  child:
                      Text(controller.allMessagesData[index]['messageBody'])),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.message,
                decoration: InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: controller.createChat,
                        icon: Icon(Icons.send))),
              ),
            )
          ],
        );
      }),
    );
  }
}
