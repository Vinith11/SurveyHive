import 'package:flutter/material.dart';
import 'package:hackathon/survey/survey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../backend/backend.dart';
//
// import 'survey_model.dart';
// import 'auth_provider.dart';

class SurveyProvider with ChangeNotifier {
  List<Survey> _surveys = [];

  List<Survey> get surveys => _surveys;

  Future<void> fetchSurveys(String jwt) async {
    final response = await http.get(
      Uri.parse('$BaseUrl/api/surveys'),
      headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _surveys = jsonResponse.map((data) => Survey.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load surveys');
    }
  }
}