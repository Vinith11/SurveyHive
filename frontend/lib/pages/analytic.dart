import 'package:flutter/material.dart';
import 'package:hackathon/backend/backend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../survey/surveydetails.dart';
import 'authprovider.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<dynamic> _surveys = [];
  bool _isLoadingSurveys = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchSurveys();
  }

  Future<void> _fetchSurveys() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await http.get(
      Uri.parse('$BaseUrl/api/surveys'),
      headers: {
        'Authorization': 'Bearer ${authProvider.jwt}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        _surveys = data;
        _isLoadingSurveys = false;
      });
    } else {
      setState(() {
        _isLoadingSurveys = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: _isLoadingSurveys
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _surveys.length,
        itemBuilder: (context, index) {
          final survey = _surveys[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.poll, color: Theme.of(context).primaryColor),
              title: Text(
                survey['title'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Survey ID: ${survey['id']}'),
              trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyDetailScreen(
                      surveyId: survey['id'],
                      surveyTitle: survey['title'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
