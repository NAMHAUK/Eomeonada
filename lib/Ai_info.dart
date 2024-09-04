import 'dart:convert';

class AiInfo{
  String ai_id;
  String name;
  String mbti;
  int age;
  List<String> questions;

  AiInfo({
    required this.ai_id,
    required this.name,
    required this.age,
    required this.mbti,
    required this.questions,
  });

  factory AiInfo.fromJson(Map<String, dynamic> json) {
    return AiInfo(
      ai_id: json['ai_id'],
      name: json['name'],
      age: json['age'],
      mbti: json['mbti'],
      questions: json['questions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ai_id': ai_id,
      'name': name,
      'age': age,
      'mbti': mbti,
      'questions': questions,
    };
  }
}

