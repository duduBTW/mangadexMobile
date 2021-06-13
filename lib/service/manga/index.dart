import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;

  MangaController(this.http);

  List<MangaModel>? _recentMangas;

  List<MangaModel>? get recentMangas => _recentMangas;

  void getRecentMangas() async {
    _recentMangas = await MangaControllerHelper.getRecentMangasData(http);
    notifyListeners();
  }
}

class MangaControllerHelper {
  static Future<List<MangaModel>> getRecentMangasData(
      MangadexService http) async {
    var response = await http.get("/manga?limit=20&order[createdAt]=desc");

    print(response.data['results']!
        .map((mangaItemApi) => MangaModel.fromJson(mangaItemApi))
        .toList());

    List<MangaModel> mangas = [];
    List<String> ids = [];

    int i = 0;
    for (dynamic mangaItemApi in response.data['results']) {
      mangas.add(MangaModel.fromJson(mangaItemApi));
      ids.add(mangas[i].data.id);
      i++;
    }

    var covers = await CoverControllerHelper.getCoversData(http, ids);
    print(covers);
    for (var cover in covers) {
      var mangaId = cover.relationships
          .firstWhere((rlCover) => rlCover.type == "manga")
          .id;

      print(mangaId);

      for (var iM = 0; iM < mangas.length; iM++) {
        var mI = mangas[iM];
        print(mI.data.id);
        print(mangaId);
        print("--");
        if (mI.data.id == mangaId) {
          mangas[iM].data.coverLink =
              "https://uploads.mangadex.org/covers/${mangaId}/${cover.data.attributes.fileName}.512.jpg";
        }
      }
    }

    return mangas;
  }
}
