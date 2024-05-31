import 'package:demo/app/common/token_keeper.dart';
import 'package:demo/app/modules/all_blogs_screen/all_blogs_screen.dart';
import 'package:demo/app/modules/event_category/all_events_category.dart';
import 'package:demo/app/modules/get_all_events/get_all_events_screen.dart';
import 'package:demo/app/modules/home/views/widgets/user_data_screen.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';

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
        actions: [
          TextButton(
              onPressed: () {
                TokenKeeper.clear();
                Get.offAllNamed(Routes.LOGIN_SELECT);
              },
              child: const Text('Logout')),
          const SizedBox(width: 10)
        ],
      ),
      drawer: const Drawer(
        child: UserDataScreen(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  Get.to(() => const GetAllBlogsScreen());
                },
                title: 'All Blogs',
              ),
              CustomButton(
                onPressed: () {
                  Get.to(() => const GetAllEventsScreen());
                },
                title: 'All Events',
              ),
              CustomButton(
                onPressed: () {
                  Get.to(() => const AllEventsCategory());
                },
                title: 'All Event Category',
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Get.to(const HomeScreen());
      // }),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          width: 200,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// class TestView extends StatefulWidget {
//   const TestView({super.key});

//   @override
//   State<TestView> createState() => _TestViewState();
// }

// class _TestViewState extends State<TestView> {
//   bool isLoading = false;
//   String name = '';
//   apiCall() {
//     isLoading = true;
//     setState(() {});
//     String pass = '';
//     final url1 = Uri.parse(
//         'https://kumele-backend.vercel.app/api/auth/passkey/generate/challenge');
//     final url2 = Uri.parse(
//         'https://kumele-backend.vercel.app/api/auth/passkey/verify/challenge');

//     http.post(url1, body: {"email": "muj.i@icloud.com"}).then((response) {
//       log(response.body);
//       pass = jsonDecode(response.body)['data']['passkey_challenge'];
//     }).then((value) {
//       return http.post(url2, body: {
//         "email": "muj.i@icloud.com",
//         "key": pass,
//       }).then((response) {
//         log(response.body);
//         isLoading = false;
//         setState(() {});
//       });
//     });
//     isLoading = false;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test View'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: apiCall,
//           child: const Text(
//             'Test View',
//             style: TextStyle(fontSize: 32),
//           ),
//         ),
//       ),
//     );
//   }
// }
