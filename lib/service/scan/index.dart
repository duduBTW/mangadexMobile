import 'package:mangadex/service/http.dart';

import 'model/index.dart';

class ScanlationGroupDataControllerHelper {
  static Future<List<ScanlationGroupDataModel>> getScans(MangadexService http,
      {List<String>? ids}) async {
    var link = "https://api.mangadex.org/group?limit=20";
    if (ids != null) {
      for (var id in ids) {
        link += "&ids[]=$id";
      }
    }
    var response = await http.get(link);

    List<ScanlationGroupDataModel> scans = [];

    for (dynamic coverItemApi in response.data['results']) {
      scans.add(ScanlationGroupDataModel.fromJson(coverItemApi['data']));
    }

    return scans;
  }
}
