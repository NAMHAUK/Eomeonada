import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void sendMessage(String text, String userName, bool isMe, String profileImage) {
    _messages.add(ChatMessage(
        text: text, userName: userName, isMe: isMe, profileImage: profileImage));
    notifyListeners();
  }
}

class ChatMessage {
  final String text;
  final String userName;
  final bool isMe;
  final String profileImage;

  ChatMessage(
      {required this.text,
        required this.userName,
        required this.isMe,
        required this.profileImage});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(message.profileImage),
              //프로필 사진 추가
              radius: 20,
            ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  message.userName,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: message.isMe ? Colors.blue[100] : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                    message.isMe ? Radius.circular(12) : Radius.circular(0),
                    bottomRight:
                    message.isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: Text(
            '채팅방 이름',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          color: Colors.lightBlue[50], // 배경색 하늘색 설정
          child: Column(
            children: <Widget>[
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    return ListView.builder(
                      reverse: false,
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messages[index];
                        return ChatBubble(message: message);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatInputField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: '메시지를 입력하세요',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            final messageText = _controller.text;
            if (messageText.isNotEmpty) {
              // 예시 프로필 이미지 추가
              Provider.of<ChatProvider>(context, listen: false).sendMessage(
                  messageText, '사용자', true,
                  'https://example.com/profile_image.png');
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
