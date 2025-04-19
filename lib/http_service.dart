import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL = "https://quran-api.santrikoding.com/api/surah";
  Future<List<Alquran>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Alquran> posts = body
          .map(
            (dynamic item) => Alquran.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
