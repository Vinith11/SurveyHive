import 'package:flutter/material.dart';
import 'package:hackathon/survey/survey.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../backend/backend.dart';
import '../pages/authprovider.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late Future<List<Survey>> _futureSurveys;

  @override
  void initState() {
    super.initState();
    _futureSurveys = _fetchSurveys();
  }

  Future<List<Survey>> _fetchSurveys() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await http.get(
      Uri.parse('$BaseUrl/api/surveys'),
      headers: {
        'Authorization': 'Bearer ${authProvider.jwt}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Survey.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load surveys');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surveys'),
      ),
      body: FutureBuilder<List<Survey>>(
        future: _futureSurveys,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No surveys available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final survey = snapshot.data![index];
                return ListTile(
                  title: Text(survey.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: survey.questions
                        .map((question) => Text('• $question'))
                        .toList(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}