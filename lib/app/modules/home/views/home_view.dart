import 'dart:developer';

import 'package:demo/app/data/token_keeper.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.wait1Sec();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TokenKeeper.name ?? 'No name',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Text(TokenKeeper.email ?? 'No email',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          TokenKeeper.clear();
                          Get.offAllNamed(Routes.AUTH);
                        },
                        child: const Text('Logout',
                            style: TextStyle(fontSize: 20))),
                  ],
                ),
              );
      }),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   log(TokenKeeper.accessToken.toString());
      // }),
    );
  }
}
