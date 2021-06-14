import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;

  MangaController(this.http);

  List<MangaModel>? _recentMangas;
  List<MangaModel>? _userMangas;

  List<MangaModel>? get recentMangas => _recentMangas;
  List<MangaModel>? get userMangas => _userMangas;

  void getRecentMangas() async {
    _recentMangas = await MangaControllerHelper.getRecentMangasData(http);
    notifyListeners();
  }

  void getUserMangas() async {
    _userMangas = await MangaControllerHelper.getUserMangasData(http);
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
      ids.add(mangas[i]
          .relationships
          .firstWhere((rlCover) => rlCover.type == "cover_art")
          .id);
      i++;
    }

    mangas = await CoverControllerHelper.vinculateCovers(http, mangas, ids);

    return mangas;
  }

  static Future<List<MangaModel>> getUserMangasData(
      MangadexService http) async {
    var response = await http.get("/user/follows/manga?limit=30&offset=0");

    print(response.data['results']!
        .map((mangaItemApi) => MangaModel.fromJson(mangaItemApi))
        .toList());

    List<MangaModel> mangas = [];
    List<String> ids = [];

    int i = 0;
    for (dynamic mangaItemApi in response.data['results']) {
      mangas.add(MangaModel.fromJson(mangaItemApi));
      ids.add(mangas[i]
          .relationships
          .firstWhere((rlCover) => rlCover.type == "cover_art")
          .id);
      i++;
    }

    mangas = await CoverControllerHelper.vinculateCovers(http, mangas, ids);

    return mangas;
  }
}
