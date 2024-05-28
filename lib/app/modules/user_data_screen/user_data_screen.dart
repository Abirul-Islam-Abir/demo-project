import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_services/api_services.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  Map  userDataList = {};

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> userData() async {
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
      if (response.statusCode == 200) {
        userDataList = responseData['data']['user'];
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
        // Handle error
      }
    }
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: userDataList.entries.map((entry) {
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
      ),
    );
  }
}
