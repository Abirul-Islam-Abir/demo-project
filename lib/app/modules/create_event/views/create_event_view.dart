import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_event_controller.dart';

class CreateEventView extends GetView<CreateEventController> {
  const CreateEventView({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.isLoading.value = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateEventView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  labelText: 'Event Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter event description',
                  labelText: 'Event Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.guestLimitController,
                decoration: InputDecoration(
                  hintText: 'Enter event guest limit',
                  labelText: 'Event Guest Limit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.cashPriceController,
                decoration: InputDecoration(
                  hintText: 'Enter event cash price',
                  labelText: 'Event Cash Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                return controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : FilledButton(
                        onPressed: () async {
                          await controller.createEvent();
                        },
                        child: const Text('Create Event'));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
