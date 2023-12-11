import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/webtoon.dart';
import 'package:flutterwebtoon/services/api_service.dart';

// stateful widget으로 고치기
class HomeScreen extends StatelessWidget {
  // HomeScreen은 const가 될 수 없음 : Future 값을 갖는 것은 미리 값을 알 수 없음
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(fontSize: 24),
        ),
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: webtoons,
        // context : BuildContext
        // snapshot : Future의 상태를 알 수 있음
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ListView.builder는 ListView의 optimized된 컴포넌트
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
