import 'dart:convert';
import 'package:flutterwebtoon/models/webtoon_detail_model.dart';
import 'package:flutterwebtoon/models/webtoon_episode_model.dart';
import 'package:flutterwebtoon/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

// async 함수는 반환값이 항상 Future
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    // 이 부분이 응답 받을 때까지 기다리라 (await)
    // 비동기 함수 내에서만 사용할 수 있음.
    final response = await http.get(url);
    // 응답 상태가 성공일 경우
    if (response.statusCode == 200) {
      //json 으로 바꿔줌 : josonDecode
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    // url 생성
    final url = Uri.parse('$baseUrl/$id');
    // 해당 url로 응답 요청
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // response body를 디코드하여 json을 받음
      final webtoon = jsonDecode(response.body);
      // json을 constructor WebtoonDetailModel로 전달
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      // json마다 새로운 WebtoonEpisodeModel 생성하여 episodesInstances에 담아줌
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
