import 'package:flutter/material.dart';
import 'fetchSurvey.dart';
import 'surveyform.dart';
import 'survey.dart';

class FillSurveyScreen extends StatefulWidget {
  @override
  _FillSurveyScreenState createState() => _FillSurveyScreenState();
}

class _FillSurveyScreenState extends State<FillSurveyScreen> {
  late Future<List<Survey>> futureSurveys;

  @override
  void initState() {
    super.initState();
    futureSurveys = fetchSurveys(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Survey'),
      ),
      body: FutureBuilder<List<Survey>>(
        future: futureSurveys,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final surveys = snapshot.data!;
            return ListView.builder(
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
                            surveyId: survey.id,
                            survey: null,
                          ),
                        ),
                      );
                    },
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
