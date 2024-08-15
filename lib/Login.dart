import 'package:eomeonada/Home.dart';
import 'package:eomeonada/main.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'eomeonada app login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                Text('Enjoy Us!'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                  child: Text(
                    '카카오톡 로그인',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool loginSuccess = true; // 이게 영준 선배가 준다는 모시기 값인가...

    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 인증 확인'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0)
            ),
          ),

          ),
          onPressed: () {
            if (loginSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('로그인 인증'),
                  content: Text('로그인 성공'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        //Navigator.of(context).pop(); 이건 잘못 됐을 때 아닌가
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      child: Text('확인'),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            '로그인 인증 확인',
            style: TextStyle(
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
