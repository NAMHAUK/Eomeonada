import 'package:flutter/material.dart';

class Create_Ai extends StatefulWidget {
  @override
  _CreateAiPageState createState() => _CreateAiPageState();
}

class _CreateAiPageState extends State<Create_Ai> {
  // 각 질문에 대한 선택한 답변을 저장할 변수
  Map<String, String> selectedAnswers = {};
  // 사용자 입력값을 저장할 변수
  Map<String, TextEditingController> controllers = {};
  // 동적으로 생성된 질문들을 저장하는 변수
  List<String> dynamicQuestions = [];

  @override
  void initState() {
    super.initState();
    // 초기화 시 모든 입력 필드를 컨트롤할 수 있는 컨트롤러 생성
    controllers['name'] = TextEditingController();
    controllers['age'] = TextEditingController();
    controllers['mbti'] = TextEditingController();
  }

  @override
  void dispose() {
    // 페이지 종료 시 모든 컨트롤러를 해제
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
  void _saveData() {
    // 사용자가 입력한 데이터를 저장하는 로직
    String name = controllers['name']?.text ?? '';
    String age = controllers['age']?.text ?? '';
    String mbti = controllers['mbti']?.text ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('완료'),
          content: Text('나만의 AI 생성이 완료되었습니다!'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 이전 화면으로 돌아가기
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI 생성 화면'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildTextField('이름이 뭐야?', 'name'),
          buildTextField('나이는?', 'age'),
          buildTextField('MBTI는?', 'mbti'),
          buildQuestion(
            '성별은?',
            ['남자', '여자'],
          ),
          buildQuestionWithCustomOption(
            '나 슬퍼서 빵 샀어',
            [
              '슬픈데 빵을 왜 사?',
              '무슨 슬픈 일이 있었는데?',
              '나도 빵 먹을래',
              '기타',
            ],
          ),
          buildQuestionWithCustomOption(
            '갑자기 누가 100명 앞에서 발표를 하래',
            [
              '얼른 발표 준비를 해야겠다',
              '100명 앞에서? 안 해 아니 못 해',
              '발표 말고 노래 부르면 안 돼?',
              '기타',
            ],
          ),
          buildQuestionWithCustomOption(
            '내일 갑자기 지구가 멸망하면 어떡할거야?',
            [
              '지구가 갑자기 왜 멸망해',
              '지금 할 수 있는 일에 최선을 다하며 소중한 사람들과 시간을 보낼 거야',
              '화성으로 가야지',
              '기타',
            ],
          ),
          buildQuestionWithCustomOption(
            '나 애인 생겼어',
            [
              '진짜? 너무 축하해 오래 가',
              '저번처럼 하다가 차이지나 마라',
              '나도 연애할래 여소/남소 해줘',
              '기타',
            ],
          ),
          // 추가된 질문들을 동적으로 렌더링
          ...dynamicQuestions.map((dynamicQuestion) {
            return buildTextField(dynamicQuestion, dynamicQuestion);
          }).toList(),
          SizedBox(height: 20.0),
         OutlinedButton(
            onPressed: _addQuestion,
            child: Text('질문 추가'),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: _saveData,
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _addQuestion() {
    // 사용자가 질문을 추가할 수 있는 다이얼로그
    TextEditingController questionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('질문 추가'),
          content: TextField(
            controller: questionController,
            decoration: InputDecoration(hintText: '질문을 입력하세요'),
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                setState(() {
                  dynamicQuestions.add(questionController.text);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  // TextField를 생성하는 함수
  Widget buildTextField(String question, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controllers[key],
          decoration: InputDecoration(
            hintText: '답변을 입력하세요',
          ),
        ),
        Divider(),
      ],
    );
  }

  // 일반적인 질문을 생성하는 함수 (기타 선택지 없음)
  Widget buildQuestion(String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        ...options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedAnswers[question],
            onChanged: (value) {
              setState(() {
                selectedAnswers[question] = value!;
              });
            },
          );
        }).toList(),
        Divider(),
      ],
    );
  }

  // 기타 옵션이 있는 질문을 생성하는 함수
  Widget buildQuestionWithCustomOption(String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        ...options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedAnswers[question],
            onChanged: (value) {
              setState(() {
                selectedAnswers[question] = value!;
              });
            },
          );
        }).toList(),
        // '기타'가 선택되었을 때 추가 입력 필드 표시
        if (selectedAnswers[question] == '기타')
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  selectedAnswers[question + '_기타'] = value;
                });
              },
              decoration: InputDecoration(
                hintText: '기타 내용을 입력하세요',
              ),
            ),
          ),
        Divider(),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Create_Ai(),
  ));
}
