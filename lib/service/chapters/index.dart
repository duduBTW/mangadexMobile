import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';

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
      chaps.add(ChapterModel.fromJson(coverItemApi['data']));
    }

    return chaps;
  }

  static Future<String> getServer(MangadexService http, String idChar) async {
    var response = await http.get("/at-home/server/$idChar");

    return response.data['baseUrl'];
  }
}
