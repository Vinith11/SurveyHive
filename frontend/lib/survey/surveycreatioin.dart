import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../backend/backend.dart';
import '../pages/authprovider.dart';

class SurveyCreationScreen extends StatefulWidget {
  @override
  _SurveyCreationScreenState createState() => _SurveyCreationScreenState();
}

class _SurveyCreationScreenState extends State<SurveyCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  List<String> questions = ['', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Survey'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onChanged: (value) => title = value,
                ),
                ...questions.asMap().entries.map((entry) {
                  int index = entry.key;
                  String question = entry.value;
                  return TextFormField(
                    decoration: InputDecoration(labelText: 'Question ${index + 1}'),
                    onChanged: (value) => questions[index] = value,
                  );
                }).toList(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.post(
                        Uri.parse('$BaseUrl/api/surveys'),
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer ${authProvider.jwt}',
                        },
                        body: jsonEncode({
                          'title': title,
                          'questions': questions,
                        }),
                      );
        
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Survey Created Successfully')),
                        );
                        Navigator.pushNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create survey')),
                        );
                      }
                    }
                  },
                  child: Text('Create Survey'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Button background color
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color on the button
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
