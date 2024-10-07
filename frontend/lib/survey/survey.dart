class Survey {
  final int id;
  final String title;
  final List<String> questions;

  Survey({required this.id, required this.title, required this.questions});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'],
      title: json['title'],
      questions: List<String>.from(json['questions']),
    );
  }
}

class SurveyResponse {
  final int id;
  final int surveyId;
  final Map<String, String> responses;

  SurveyResponse({required this.id, required this.surveyId, required this.responses});

  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return SurveyResponse(
      id: json['id'],
      surveyId: json['surveyId'],
      responses: Map<String, String>.from(json['responses']),
    );
  }
}
