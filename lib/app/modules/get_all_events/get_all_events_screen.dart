
import 'package:demo/app/modules/get_all_events/get_all_events_controller.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../event_by_id/views/event_by_id_view.dart';

class GetAllEventsScreen extends StatefulWidget {
  const GetAllEventsScreen({super.key});

  @override
  State<GetAllEventsScreen> createState() => _GetAllEventsScreenState();
}

class _GetAllEventsScreenState extends State<GetAllEventsScreen> {
  final GetAllEventController controller = Get.put(GetAllEventController());

  @override
  void initState() {
    controller.allEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.allEventsData.length,
                itemBuilder: (context, index) {
                  final blog = controller.allEventsData[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(blog.title.toString()),
                      subtitle: Text(blog.description.toString()),
                      onTap: () {
                        Get.to(() => EventByIdView(), arguments: blog.id);
                      },trailing: Icon(Icons.arrow_forward_outlined),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_EVENT);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
