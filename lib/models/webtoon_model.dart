// named constructor
class WebtoonModel {
  final String title, thumb, id;

// Map : key-value structure
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
