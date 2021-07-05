import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'package:mangadex/service/shared/tuple/index.dart';

import 'model/aggregate/index.dart';
import 'dart:convert';

class ChaptersControllerHelper {
  static final storage = new FlutterSecureStorage();

  static Future<MangaAgreModel> getAggregate(
      MangadexService http, String id) async {
    var result = await http.get("/manga/$id/aggregate");

    return MangaAgreModel.fromJson(result.data);
  }

  static Future<List<ChapterModel>> getChapter(
      MangadexService http, String idManga, String idChar) async {
    String url = "/chapter?manga=$idManga&chapter[]=$idChar";
    url = await getTranslatedLanguageUrl(url);

    var response = await http.get(url);

    List<ChapterModel> chaps = [];

    for (dynamic coverItemApi in response.data['results']) {
      print(coverItemApi);
      chaps.add(ChapterModel.fromJson(coverItemApi));
    }

    return chaps;
  }

  static Future<String> getTranslatedLanguageUrl(String url) async {
    var languages = await storage.read(key: 'DEF_LANGUAGE');

    if (languages == null) return url;
    var languagesList = json.decode(languages);

    for (var id in languagesList) {
      url += "&translatedLanguage[]=$id";
    }

    return url;
  }

  static Future<String> getTContentRatingUrl(String url) async {
    var contentFilters = await storage.read(key: 'DEF_CONTENT_FILTERS');

    if (contentFilters == null) return url;
    var contentFiltersList = json.decode(contentFilters);

    for (var id in contentFiltersList) {
      url += "&contentRating[]=$id";
    }

    return url;
  }

  static Future<Tuple<List<ChapterModel>, PaginationModel>> getLatestChapter(
      MangadexService http,
      {int limit = 30,
      int offset = 0}) async {
    String url =
        "/user/follows/manga/feed?limit=$limit&offset=$offset&order[publishAt]=desc";

    url = await getTranslatedLanguageUrl(url);
    var response = await http.get(url);

    List<ChapterModel> chaps = [];

    for (dynamic coverItemApi in response.data['results']) {
      chaps.add(ChapterModel.fromJson(coverItemApi));
    }

    return Tuple<List<ChapterModel>, PaginationModel>(
        item1: chaps,
        item2: PaginationModel(
          limit: response.data['limit'],
          offset: response.data['offset'],
          total: response.data['total'],
        ));

    // return chaps;
  }

  static Future<Tuple<List<ChapterModel>, PaginationModel>>
      getGeneralLatestChapter(MangadexService http,
          {int limit = 30, int offset = 0}) async {
    String url = "/chapter?limit=$limit&offset=$offset&order[publishAt]=desc";

    url = await getTranslatedLanguageUrl(url);
    var response = await http.get(url);

    List<ChapterModel> chaps = [];

    for (dynamic coverItemApi in response.data['results']) {
      chaps.add(ChapterModel.fromJson(coverItemApi));
    }

    return Tuple<List<ChapterModel>, PaginationModel>(
        item1: chaps,
        item2: PaginationModel(
          limit: response.data['limit'],
          offset: response.data['offset'],
          total: response.data['total'],
        ));
  }

  static Future<String> getServer(MangadexService http, String idChar) async {
    var response = await http.get("/at-home/server/$idChar");

    return response.data['baseUrl'];
  }
}
