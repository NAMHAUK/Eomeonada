import 'package:eomeonada/Home.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase 초기화
  await Supabase.initialize(
    url: 'https://lbgqvqsioqayyqrapeae.supabase.co', // Supabase 프로젝트 URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxiZ3F2cXNpb3FheXlxcmFwZWFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2ODE5MzIsImV4cCI6MjAzOTI1NzkzMn0.EgHPmLy1XtX4BEFhfwK2Fz3-BnsqyuU8ZRjxA34QYaQ', // Supabase anon 키
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}