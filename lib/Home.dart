import 'package:eomeonada/Create_AI.dart';
import 'package:flutter/material.dart';
import 'package:eomeonada/ChatType.dart';

void main() {
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 페이지'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200, // 버튼의 너비
              height: 60, // 버튼의 높이
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 300), // 버튼의 최소 크기
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatType()),
                  );
                },
                child: Text('채팅 시작하기'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, // 버튼의 너비
              height: 60, // 버튼의 높이
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 300), // 버튼의 최소 크기
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Create_Ai()),
                  );
                },
                child: Text('나만의 채팅AI 생성하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
