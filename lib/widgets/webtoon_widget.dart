import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            // 이미지가 바닥에서부터 올라옴 (해당 설정 없을 경우 옆으로 네비게이션)
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
              width: 250,
              // clipbehavior : 자식이 부모 영역 침범시에 자름
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]),
              child: Image.network(thumb)),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
