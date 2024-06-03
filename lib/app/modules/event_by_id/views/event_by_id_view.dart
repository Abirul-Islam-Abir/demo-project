import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../all_messages_by_chat_id/views/all_messages_by_chat_id_view.dart';
import '../controllers/event_by_id_controller.dart';

class EventByIdView extends StatelessWidget {
  EventByIdView({super.key});

  final controller = Get.put(EventByIdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event By Id'),
      ),
      body: GetBuilder<EventByIdController>(builder: (logic) {
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListTile(
                    leading: Image.network(
                      controller.eventByIdData['image_url'] ??
                          'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
                      height: 50,
                      width: 50,
                    ),
                    title: Text(controller.eventByIdData['title'] ?? ''),
                    subtitle:
                        Text(controller.eventByIdData['description'] ?? ''),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: const Text('Update'),
                                    content: SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'title'),
                                              controller: controller.title,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'description'),
                                              controller: controller.desc,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Update Title'),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: controller.delete,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: controller.createChat,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text('All Chats by event id',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.chatEventByIdData.length,
                      itemBuilder: (context, index) {
                        final id = controller.chatEventByIdData[index]['id'];
                        final eventId =
                            controller.chatEventByIdData[index]['event_id'];
                        return ListTile(
                          onTap: () {
                            Get.to(() => AllMessagesByChatIdView(),
                                arguments: {'event_id': eventId, 'chatId': id});
                          },
                          title: Text(id),
                          subtitle: Text(eventId),
                          trailing: Icon(Icons.arrow_forward_outlined),
                        );
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
