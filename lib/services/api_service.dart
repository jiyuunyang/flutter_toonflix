import 'dart:convert';
import 'package:flutterwebtoon/models/webtoon.dart';
import 'package:http/http.dart' as http;

class ApiService {
  List<WebtoonModel> webtoonInstances = [];
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = 'today';

  Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    // 이 부분이 응답 받을 때까지 기다리라 (await)
    // 비동기 함수 내에서만 사용할 수 있음.
    final response = await http.get(url);
    // 응답 상태가 성공일 경우
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
