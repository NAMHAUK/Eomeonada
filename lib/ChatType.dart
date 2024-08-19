import 'package:eomeonada/ChoosingAI_IncludeMe.dart';
import 'package:eomeonada/ChoosingAI_OnlyAI.dart';
import 'package:flutter/material.dart';
import 'ChatingRoom.dart';

class ChatType extends StatelessWidget {
  const ChatType({super.key});

  @override
  Widget build(BuildContext context) {
    // button Style 지정
    var buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // 텍스트 색상, onPrimary: Colors.white 이제 안씀
      backgroundColor: Colors.blue,  // 버튼 색상, primary: Colors.blue 이제 안씀
      minimumSize: const Size(200, 50), // 버튼 크기
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("채팅 타입을 선택해주세요"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: buttonStyle,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingAI_IncludeMe()));
              },
              child: Text("나 포함 채팅")
            ),

            SizedBox(height: 20), // 두 버튼 사이 간격

            ElevatedButton(
              style: buttonStyle,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Text("AI 끼리만 채팅")
            )
          ],
        )
      )
    );
  }
}
