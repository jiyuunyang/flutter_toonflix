import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/webtoon_model.dart';
import 'package:flutterwebtoon/services/api_service.dart';
import 'package:flutterwebtoon/widgets/webtoon_widget.dart';

// stateful widget으로 고치기
class HomeScreen extends StatelessWidget {
  // HomeScreen은 const가 될 수 없음 : Future 값을 갖는 것은 미리 값을 알 수 없음
  HomeScreen({super.key});

  // getTodaysToons는 의존하는 데이터가 없음(인자 없음) -> Stateless
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
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
