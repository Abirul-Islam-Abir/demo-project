import 'dart:convert';
import 'dart:developer';

import 'package:demo/app/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_services/api_services.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  Map userData = {};

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> _signUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      String body = json.encode({"token": token});
      var response = await http.post(
        Uri.parse(ApiServices.getUserDataUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      var responseData = json.decode(response.body);
      log(responseData);
      if (response.statusCode == 200) {
        userData = responseData['data']['user'];
        log(responseData['data']['user']);
        log(userData.toString());
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
        log('Failed to sign up. Status code: ${response.statusCode}');
        // Handle error
      }
    }
  }

  @override
  void initState() {
    _signUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('token');
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userData.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${entry.key}: ${entry.value}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}