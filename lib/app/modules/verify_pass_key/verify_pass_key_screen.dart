import 'dart:convert';

import 'package:demo/app/modules/user_data_screen/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api_services/api_services.dart';

class VerifyPassKeyScreen extends StatefulWidget {
  final String passKeyChallenge;
  final String mail;

  const VerifyPassKeyScreen(
      {super.key, required this.passKeyChallenge, required this.mail});

  @override
  VerifyPassKeyScreenState createState() => VerifyPassKeyScreenState();
}

class VerifyPassKeyScreenState extends State<VerifyPassKeyScreen> {
  final TextEditingController _passKeyController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> verifyPassKey() async {
    if (widget.passKeyChallenge == _passKeyController.text) {
      _isLoading = true;
      setState(() {});
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
        "email": widget.mail,
        "key": _passKeyController.text
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
        _isLoading = false;
        setState(() {});
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const UserDataScreen(),
              ),
              (route) => false);
        }
      } else {
        _isLoading = false;
        setState(() {});
        // Request failed with an error status code, handle the error
        _showSnackBar('Request failed');
      }
    } else {
      _showSnackBar('Pass key not same');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Pass Key Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  'Enter pass key to verify:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.passKeyChallenge,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passKeyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pass Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: verifyPassKey,
                    child: const Text('Verify'),
                  ),
          ],
        ),
      ),
    );
  }
}
