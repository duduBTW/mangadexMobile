import 'dart:core';
import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'package:mangadex/service/shared/tuple/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;

  MangaController(this.http);

  List<MangaModel>? _recentMangas;

  List<MangaModel>? get recentMangas => _recentMangas;

  Future<PaginationModel> getRecentMangas() async {
    // _recentMangas = await MangaControllerHelper.getRecentMangasData(http)..item1;
    var recentMangaResult =
        await MangaControllerHelper.getRecentMangasData(http);
    _recentMangas = recentMangaResult.item1;
    notifyListeners();

    return recentMangaResult.item2;
  }
}

class MangaControllerHelper {
  static Future<Tuple<List<MangaModel>, PaginationModel>> getRecentMangasData(
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

    return Tuple<List<MangaModel>, PaginationModel>(
        item1: mangas,
        item2: PaginationModel(
          limit: response.data['limit'],
          offset: response.data['offset'],
          total: response.data['total'],
        ));
  }

  static Future<Tuple<List<MangaModel>, PaginationModel>> getUserMangasData(
      MangadexService http,
      {int limit = 30,
      int offset = 0}) async {
    var response =
        await http.get("/user/follows/manga?limit=$limit&offset=$offset");

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

    return Tuple<List<MangaModel>, PaginationModel>(
        item1: mangas,
        item2: PaginationModel(
          limit: response.data['limit'],
          offset: response.data['offset'],
          total: response.data['total'],
        ));
  }
}
