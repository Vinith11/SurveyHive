import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../backend/backend.dart';
import '../pages/authprovider.dart';
import 'survey.dart';

Future<List<Survey>> fetchSurveys(BuildContext context) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final response = await http.get(
    Uri.parse('$BaseUrl/api/surveys'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider.jwt}',
    },
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((data) => Survey.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load surveys');
  }
}