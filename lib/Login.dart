import 'package:eomeonada/Home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // 영준)supabase instance 생성
  final supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future<void> _signInWithKakao() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // OAuth2 코드로 Supabase에서 로그인 처리
      final success = await supabase.auth.signInWithOAuth(OAuthProvider.kakao);
      debugPrint(success ? "success" : "failed");
      supabase.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        if(event == AuthChangeEvent.signedIn) {
          debugPrint('세션: ${data.session}');
          _navigateToSecondPage(data);
        }
      });
    } catch (error) {
      _showErrorDialog('로그인 실패: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context)=> HomePage(),
      ),
    );
  }
  void _navigateToSecondPage(data) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context)=> SecondPage(session: data.session!),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('오류'),
      content: Text(message),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context),
        child: Text('확인'),
        ),
      ],
    ));
  }  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'eomeonada app login',
            style: TextStyle(color: Colors.blue),
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
                  onPressed: _signInWithKakao,
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
  final Session session;
  SecondPage({Key? key, required this.session}) : super(key: key);
  //supabase 인스턴스 생성
  final supabase = Supabase.instance.client;

  Future<bool> attemptLogin() async {
    String userToken = session.accessToken; // 사용자의 토큰, 실제로는 카카오 API 등을 통해 얻어야 함!!
    String query = "SELECT * FROM users WHERE token = '$userToken'";

    bool isValid = await checkTokenFromDB(query);

    return isValid;
  }

  Future<bool> checkTokenFromDB(String query) async {
    // DB에서 쿼리 실행 후, 결과에 따라 true 또는 false 반환!
    // 여기에 실제 DB 통신 코드가 필요하대
    bool userExists = false;

    // 예시로 사용자 존재 여부를 가정
    if (query.contains("sampleUserToken")) {
      userExists = true;//혹은 false 눌러서 돌아가는지 확인 가능함 ! ㅎ(로그인 성공 여부)
    }

    return userExists;
  }

  Future<void> insertNewUser(String userToken) async {
    // 여기에 실제 데이터베이스에 새로운 사용자를 저장하는 로직을 작성해야 합니다.
    String insertQuery = "INSERT INTO users (token) VALUES ('$userToken')";
    // insertQuery 실행하는 로직이 필요합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 인증 확인'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
            ),
          ),
          onPressed: () async {
            bool loginSuccess = await attemptLogin();
            if (loginSuccess) {
              // 로그인 성공
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('로그인 인증'),
                  content: Text('로그인 성공'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Text('확인'),
                    ),
                  ],
                ),
              );
            } else {
              // 로그인 실패 시, 새로운 사용자 정보를 DB에 저장해야함!
              String userToken = "sampleUserToken"; // 실제 사용자 토큰으로 교체 필요함 !
              await insertNewUser(userToken);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('회원가입 완료'),
                  content: Text('회원가입이 되었습니다!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Text('확인'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text(
            '로그인 인증 확인',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}


