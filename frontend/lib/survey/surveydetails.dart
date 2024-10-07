import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../backend/backend.dart';
import '../pages/authprovider.dart';

class SurveyDetailScreen extends StatefulWidget {
  final int surveyId;
  final String surveyTitle;

  SurveyDetailScreen({required this.surveyId, required this.surveyTitle});

  @override
  _SurveyDetailScreenState createState() => _SurveyDetailScreenState();
}

class _SurveyDetailScreenState extends State<SurveyDetailScreen> {
  List<PieChartSectionData> _sections = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSurveyData(widget.surveyId);
  }

  Future<void> _fetchSurveyData(int surveyId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await http.get(
      Uri.parse('$BaseUrl/api/responses/survey/$surveyId'),
      headers: {
        'Authorization': 'Bearer ${authProvider.jwt}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        _sections = _parseData(data);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<PieChartSectionData> _parseData(List<dynamic> data) {
    Map<String, double> aggregatedData = {};
    int totalResponses = 0;

    for (var item in data) {
      Map<String, dynamic> responses = item['responses'];
      responses.forEach((key, value) {
        double numericValue = double.parse(value);
        if (aggregatedData.containsKey(key)) {
          aggregatedData[key] = aggregatedData[key]! + numericValue;
        } else {
          aggregatedData[key] = numericValue;
        }
        totalResponses += numericValue.toInt();
      });
    }

    return aggregatedData.entries.map((entry) {
      double percentage = (entry.value / totalResponses) * 100;
      return PieChartSectionData(
        color: _getRandomColor(),
        value: percentage,
        title: '${entry.key} ${percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.6,
      );
    }).toList();
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ); // You can use a random color generator or predefined colors based on your requirement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surveyTitle),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Survey ID: ${widget.surveyId}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
