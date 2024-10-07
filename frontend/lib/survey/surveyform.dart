import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../backend/backend.dart';
import '../pages/authprovider.dart';
import 'survey.dart';

class SurveyFormScreen extends StatefulWidget {
  final int surveyId;

  SurveyFormScreen({required this.surveyId, required survey});

  @override
  _SurveyFormScreenState createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends State<SurveyFormScreen> {
  late Future<Survey> futureSurvey;
  Map<String, String> responses = {};

  @override
  void initState() {
    super.initState();
    futureSurvey = fetchSurveyById(context, widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Form'),
      ),
      body: FutureBuilder<Survey>(
        future: futureSurvey,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final survey = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    survey.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: survey.questions.length,
                      itemBuilder: (context, index) {
                        final question = survey.questions[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            title: Text(
                              question,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            trailing: DropdownButton<String>(
                              value: responses[question],
                              onChanged: (value) {
                                setState(() {
                                  responses[question] = value!;
                                });
                              },
                              items: List.generate(5, (i) => (i + 1).toString())
                                  .map((val) => DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              ))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _submitResponses(survey.id),
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _submitResponses(int surveyId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse('$BaseUrl/api/responses'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider.jwt}',
      },
      body: jsonEncode({
        'surveyId': surveyId,
        'responses': responses,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Responses submitted successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit responses')),
      );
    }
  }
}

Future<Survey> fetchSurveyById(BuildContext context, int id) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final response = await http.get(
    Uri.parse('$BaseUrl/api/surveys/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider.jwt}',
    },
  );

  if (response.statusCode == 200) {
    return Survey.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load survey');
  }
}
