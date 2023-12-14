import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/webtoon_detail_model.dart';
import 'package:flutterwebtoon/models/webtoon_episode_model.dart';
import 'package:flutterwebtoon/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  // getToonById, getLatestEpisodesById는
  // widget.id 데이터에 의존하므로(전달되는 값인 인자가 필요하므로) initState를 씀 -> Stateful
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    // widget.[property] : 부모에게 가서 데이터 받기
                    tag: widget.id,
                    child: Container(
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
                        child: Image.network(widget.thumb)),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${snapshot.data!.genre} | ${snapshot.data!.age}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 25),
              FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        // collection for
                        for (var episode in snapshot.data!)
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: const Offset(5, 5),
                                      color: Colors.black.withOpacity(0.2),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(episode.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      const Icon(Icons.chevron_right,
                                          color: Colors.white)
                                    ]),
                              ))
                      ]);
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
