import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/model/index.dart';
import 'package:mangadex/service/manga/model/index.dart';

import '../http.dart';

class CoverController with ChangeNotifier {
  late final MangadexService http;
  List<CoverModel>? _recentCovers;

  List<CoverModel>? get recentCovers => _recentCovers;

  set recentCovers(List<CoverModel>? recentCovers) {
    _recentCovers = recentCovers;
    notifyListeners();
  }

  CoverController(this.http);
}

class CoverControllerHelper {
  static Future<List<MangaModel>> vinculateCovers(
      MangadexService http, List<MangaModel> mangas, List<String> ids) async {
    var covers = await CoverControllerHelper.getCoversData(http, ids);
    for (var cover in covers) {
      var mangaId = cover.relationships
          .firstWhere((rlCover) => rlCover.type == "manga")
          .id;

      for (var iM = 0; iM < mangas.length; iM++) {
        var mI = mangas[iM];
        if (mI.data.id == mangaId) {
          mangas[iM].data.coverLink =
              "https://uploads.mangadex.org/covers/$mangaId/${cover.data.attributes.fileName}.512.jpg";
        }
      }
    }

    return mangas;
  }

  static Future<List<CoverModel>> getCoversData(
      MangadexService http, List<String> ids) async {
    String link = "/cover?";

    int i = 0;
    for (var id in ids) {
      if (i == 0) {
        link += "ids[]=$id";
      } else {
        link += "&ids[]=$id";
      }
      i++;
    }

    link += "&limit=30";
    print(link);

    var response = await http.get(link);

    List<CoverModel> covers = [];

    for (dynamic coverItemApi in response.data['results']) {
      covers.add(CoverModel.fromJson(coverItemApi));
    }

    return covers;
  }
}
