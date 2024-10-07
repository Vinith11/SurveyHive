import 'package:flutter/material.dart';
import 'package:hackathon/pages/authprovider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../backend/backend.dart';
import 'surveycreatioin.dart';
import 'surveyform.dart';
import 'survey.dart';
import 'package:provider/provider.dart';

class SurveyListScreen extends StatefulWidget {
  @override
  _SurveyListScreenState createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends State<SurveyListScreen> {
  List<Survey> surveys = [];

  @override
  void initState() {
    super.initState();
    _fetchSurveys();
  }

  void _fetchSurveys() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await http.get(
      Uri.parse('$BaseUrl/api/surveys'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider.jwt}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        surveys = (jsonDecode(response.body) as List)
            .map((data) => Survey.fromJson(data))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch surveys')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: surveys.length,
                itemBuilder: (context, index) {
                  final survey = surveys[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.poll, color: Theme.of(context).primaryColor),
                      title: Text(
                        survey.title,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Survey ID: ${survey.id}'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SurveyFormScreen(
                              survey: survey,
                              surveyId: survey.id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SurveyCreationScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Create New Survey',
      ),
    );
  }
}
