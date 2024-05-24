import 'package:demo/app/api_services/api_services.dart';
import 'package:demo/app/modules/login_screen/login_screen.dart';
import 'package:demo/app/modules/user_data_screen/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../generate_pass_key/generate_pass_key_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _gender = 'male'; // Default value
  String _country = 'Pakistan'; // Default value
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});
      final String fullName = _fullNameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;
      Map<String, dynamic> data = {
        'full_name': fullName,
        'email': email,
        'gender': _gender,
        "dob": "2011-01-07T16:41:01.919Z",
        'password': password,
        'confirm_password': confirmPassword,
        "referral_code": "12345336",
        "street": "14",
        "town": "model town",
        "city": "lahore",
        "state": "punjab",
        'country': _country,
        "interests": ["036c8983-4c11-43b6-82b0-8701df609cbf"]
      };
      String body = json.encode(data);
      var response = await http.post(
        Uri.parse(ApiServices.signUpUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        _isLoading = false;
        setState(() {});
        _showSnackBar(responseData['message']);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
        _showSnackBar('Please Login again');
      } else {
        _isLoading = false;
        setState(() {});
        _showSnackBar(responseData['message']);
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Select your gender',
                  labelText: 'Gender',
                ),
                value: _gender,
                items: ['male', 'female', 'other']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Select your country',
                  labelText: 'Country',
                ),
                value: _country,
                items: ['Pakistan', 'India', 'USA', 'UK']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _country = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign Up'),
                    ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigate to the sign-up screen
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
                child: const Text("Already have an account?  Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
