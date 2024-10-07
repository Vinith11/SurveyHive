import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../backend/backend.dart';
import 'authprovider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _selectedRole;
  bool _isLoading = false;
  String? _errorMessage;

  void _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check if passwords match
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Passwords do not match';
        });
        _showErrorDialog('Error', 'Passwords do not match');
        return;
      }

      final response = await http.post(
        Uri.parse('$BaseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': _selectedRole,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status']) {
          Provider.of<AuthProvider>(context, listen: false).setJwt(data['jwt']);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          setState(() {
            _errorMessage = 'Sign up failed';
          });
          _showErrorDialog('Sign Up Failed', 'Failed to sign up. Please try again.');
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
        });
        _showErrorDialog('Server Error', 'Failed to connect to server. Please try again later.');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      _showErrorDialog('Error', 'An error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showErrorDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            DropdownButton<String>(
              value: _selectedRole,
              hint: Text('Select Role'),
              items: ['user', 'admin'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: Text(
                'Already have an Account? Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
