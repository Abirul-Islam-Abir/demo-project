import 'dart:convert';

import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/modules/verify_pass_key/verify_pass_key_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassKeyScreen extends StatefulWidget {
  final String mail;

  const PassKeyScreen({super.key, required this.mail});
  @override
  State<PassKeyScreen> createState() => _PassKeyScreenState();
}

class _PassKeyScreenState extends State<PassKeyScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<void> generatePassKey() async {
    _isLoading = true;
    setState(() {});
    // Define the endpoint URL
    var url = Uri.parse(ApiServices.generatePassKeyUrl);
    // Define the data to be sent in the body of the request
    var data = {"email": _emailController.text};

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
      _isLoading = false;
      setState(() {});
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyPassKeyScreen(
              mail: _emailController.text,
              passKeyChallenge: responseData['data']['passkey_challenge']),
        ));
      }
    } else {
      _isLoading = false;
      setState(() {});
      // Request failed with an error status code, handle the error
      _showSnackBar('Request failed');
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
  void initState() {
    _emailController.text = widget.mail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Pass Key Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your email to generate pass key challenge:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: generatePassKey,
                    child: const Text('Generate Challenge'),
                  ),
          ],
        ),
      ),
    );
  }
}
