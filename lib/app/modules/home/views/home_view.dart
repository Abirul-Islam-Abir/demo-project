import 'package:demo/app/data/token_keeper.dart';
import 'package:demo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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
      //   Get.to(const TestView());
      // }),
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
