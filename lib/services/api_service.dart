import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';

  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final uri = Uri.parse('$baseUrl/$today');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      return webtoons.map((e) => WebtoonModel.fromJson(e)).toList();
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final uri = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      return episodes.map((e) => WebtoonEpisodeModel.fromJson(e)).toList();
    }
    throw Error();
  }
}
