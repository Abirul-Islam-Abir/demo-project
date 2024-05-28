import 'package:demo/app/modules/get_all_events/get_all_events_screen.dart';
import 'package:demo/app/modules/user_data_screen/user_data_screen.dart';
import 'package:flutter/material.dart';

import '../all_blogs_screen/all_blogs_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  navigate(context, screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: UserDataScreen(),
      ),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  navigate(context, const GetAllBlogsScreen());
                },
                child: const Text('Get All Blogs')),
            TextButton(
                onPressed: () {
                  navigate(context, const GetAllEventsScreen());
                },
                child: const Text('Get all events')),
            TextButton(
                onPressed: () {}, child: const Text('Get all event category')),
            TextButton(onPressed: () {}, child: const Text('Get all chats')),
          ],
        ),
      ),
    );
  }
}
