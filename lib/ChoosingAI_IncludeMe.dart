import 'package:flutter/material.dart';

class ChoosingAI_IncludeMe extends StatefulWidget {
  const ChoosingAI_IncludeMe({super.key});

  @override
  State<ChoosingAI_IncludeMe> createState() => _ChoosingAI_IncludeMeState();
}

class _ChoosingAI_IncludeMeState extends State<ChoosingAI_IncludeMe> {
  final ScrollController _scrollController = ScrollController();
  bool _showArrows = false;
  late List<bool> _isAlterImage;
  @override
  void initState() {
    super.initState();
    _isAlterImage = List<bool>.filled(images.length, false);
  }

  final List<String> images = [
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
    "assets/image5.png",
    "assets/image6.png",
  ];
  final List<String> alterImages = [
    "assets/image6.png",
    "assets/image5.png",
    "assets/image4.png",
    "assets/image3.png",
    "assets/image2.png",
    "assets/image1.png",
  ];
  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _swapImage(int index) {
    setState(() {
      if (_isAlterImage[index]) {
        images[index] = "assets/image${index + 1}.png"; // 원래 이미지로 변경
      } else {
        images[index] = alterImages[index]; // 대체 이미지로 변경
      }
      _isAlterImage[index] = !_isAlterImage[index]; // 상태 토글
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("캐릭터 선택"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: MouseRegion(
        onEnter: (_){ // 마우스가 list에 위일 때
          setState(() {
            _showArrows = true;
          });
        },
        onExit: (_){ // 마우스가 list에 없을 때
          setState(() {
            _showArrows = false;
          });
        },

        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '인기 순위',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(images.length, (index){
                        return GestureDetector(
                          onTap: () => _swapImage(index),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              images[index],
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            if(_showArrows)
              Positioned(
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: _scrollLeft
                ),
              ),

            if(_showArrows)
              Positioned(
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white,),
                  onPressed: _scrollRight
                ),
              )
          ],
        )
      ),
    );
  }
}
