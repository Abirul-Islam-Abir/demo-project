import 'dart:convert';

import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/data.dart';
import 'package:demo/app/modules/generate_pass_key/generate_pass_key_screen.dart';
import 'package:demo/app/modules/sign_up_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Create a map containing the email and password
      Map<String, String> data = {
        'email': email,
        'password': password,
      };

      // Convert the data map to JSON
      String body = json.encode(data);

      // Send the POST request to your API endpoint
      var response = await http.post(
        Uri.parse(ApiServices.signInUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await SharedPref.storeToken(responseData['data']['response']['token']);
        _showSnackBar('${responseData['message']}');
        if (mounted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PassKeyScreen(
                    mail: _emailController.text,
                  )));
        }
        _isLoading = false;
        setState(() {});
      } else {
        _showSnackBar('${responseData['message']}');
        _isLoading = false;
        setState(() {});
      }
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
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more specific validation for email format if needed
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // You can add more specific validation for password strength if needed
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () => _login(context),
                      child: const Text('Login'),
                    ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                      (route) => false);
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
