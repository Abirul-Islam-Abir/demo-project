import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/modules/user_data_screen/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_passkey/flutter_passkey.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewSignUpView extends StatelessWidget {
  const NewSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewSignUpController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up using PassKey'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          final Future<String> options = controller
                              .generatePassKey(controller.emailController.text);
                          controller.flutterPasskeyPlugin
                              .createCredential(await options)
                              .then((response) {})
                              .catchError((error) {
                            log(error.toString());
                          });
                        },
                        child: const Text('Register'),
                      ),
              ),
              Obx(
                () => controller.isLoading2.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          final Future<String> options =
                              controller.verifyPassKey();
                          controller.flutterPasskeyPlugin
                              .getCredential(await options)
                              .then((response) {
                            Get.to(() => const UserDataScreen());
                            log(response.toString());
                          }).catchError((error) {
                            Get.snackbar('Request failed', '');
                            log(error.toString());
                          });
                        },
                        child: const Text('Verify PassKey'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewSignUpController extends GetxController {
  final flutterPasskeyPlugin = FlutterPasskey();
  RxBool isPasskeySupported = false.obs;

  RxBool isLoading2 = false.obs;
  Future<String> verifyPassKey() async {
    isLoading2.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {
      "attestationData":
          "I2NzRiMmEzYS1mMzgzLTRiNDYtYmMzMi0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYy",
      "authentication": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOi",
      "clientData": "RzdLKcV94edLdBN5t1w1_f67PKKPrUUEM-iTiFfQ",
      "credentials": {
        "algorithm": "RS256",
        "id": "0yODYxMjk5MzE1MjUiLCJpYXQiOjE3MTYyMjE"
      },
      "email": emailController.text,
      "key": passKeyController.text
    };

    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      headers: {
        'Content-Type': 'application/json', // Define the content type as JSON
      },
    );
    //final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading2.value = false;
      update();

      return response.toString();
    } else {
      isLoading2.value = false;
      update();
      // Request failed with an error status code, handle the error

      return response.toString();
    }
  }

  @override
  void onInit() {
    super.onInit();
    flutterPasskeyPlugin.isSupported().then((value) {
      return isPasskeySupported.value = value;
    });
  }

  final emailController = TextEditingController();

  final TextEditingController passKeyController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<String> generatePassKey(String email) async {
    isLoading.value = true;
    update();
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {"email": emailController.text};

    // Make the POST request
    var response = await http.post(
      url,
      body: jsonEncode(data), // Encode the data to JSON format
      headers: {
        'Content-Type': 'application/json', // Define the content type as JSON
      },
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      update();

      log(responseData.toString());
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => VerifyPassKeyScreen(
      //       mail: _emailController.text,
      //       passKeyChallenge: responseData['data']['passkey_challenge']),
      // ));
      passKeyController.text = responseData['data']['passkey_challenge'];
      return responseData.toString();
    } else {
      isLoading.value = false;
      update();
      return response.toString();
      // Request failed with an error status code, handle the error
    }
  }
}
