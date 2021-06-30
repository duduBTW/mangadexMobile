import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'package:mangadex/service/shared/tuple/index.dart';

import 'model/aggregate/index.dart';

class ChaptersControllerHelper {
  static Future<MangaAgreModel> getAggregate(
      MangadexService http, String id) async {
    var result = await http.get("/manga/$id/aggregate");

    return MangaAgreModel.fromJson(result.data);
  }

  static Future<List<ChapterModel>> getChapter(
      MangadexService http, String idManga, String idChar) async {
    var response = await http.get("/chapter?manga=$idManga&chapter[]=$idChar");

    List<ChapterModel> chaps = [];

    for (dynamic coverItemApi in response.data['results']) {
      print(coverItemApi);
      chaps.add(ChapterModel.fromJson(coverItemApi));
    }

    return chaps;
  }

  static Future<Tuple<List<ChapterModel>, PaginationModel>> getLatestChapter(
      MangadexService http,
      {int limit = 30,
      int offset = 0}) async {
    var response = await http.get(
        "/user/follows/manga/feed?limit=$limit&offset=$offset&order[publishAt]=desc");

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

  static Future<List<ChapterModel>> getGeneralLatestChapter(
      MangadexService http) async {
    var response = await http.get("/chapter?limit=20&order[publishAt]=desc");

    List<ChapterModel> chaps = [];

    for (dynamic coverItemApi in response.data['results']) {
      chaps.add(ChapterModel.fromJson(coverItemApi));
    }

    return chaps;
  }

  static Future<String> getServer(MangadexService http, String idChar) async {
    var response = await http.get("/at-home/server/$idChar");

    return response.data['baseUrl'];
  }
}
