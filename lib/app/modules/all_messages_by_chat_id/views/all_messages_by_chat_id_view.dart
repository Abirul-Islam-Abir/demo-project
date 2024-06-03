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
                itemBuilder: (context, index) {
                  String messageId =
                      controller.allMessagesData[index]['id'].toString();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.allMessagesData[index]['messageBody']),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: const Text('Update'),
                                    content: SizedBox(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'New Message'),
                                              controller:
                                                  controller.updateController,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () { controller.updateMessage(id: messageId);

                                            },
                                            child: const Text('Update Message'),
                                          ),
                                        ],
                                      ),
                                    )));
                          },
                          icon: Icon(Icons.edit))
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.messageController,
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
