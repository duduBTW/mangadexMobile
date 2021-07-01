import 'dart:core';
import 'package:flutter/material.dart';
import 'package:mangadex/service/chapters/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'package:mangadex/service/shared/tuple/index.dart';

import 'model/tags/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;

  MangaController(this.http);

  List<MangaModel>? _recentMangas;

  List<MangaModel>? get recentMangas => _recentMangas;

  // Recent
  List<ChapterModel>? _recentChapters;
  List<ChapterModel>? get recentChapters => _recentChapters;

  Map<String, MangaModel>? _recentChaptersMangas;
  Map<String, MangaModel>? get recentChaptersMangas => _recentChaptersMangas;

  Future<PaginationModel> getRecentMangas() async {
    _recentMangas = null;

    var recentMangaResult = await MangaControllerHelper.getMangasData(http);
    _recentMangas = recentMangaResult.item1;
    notifyListeners();

    return recentMangaResult.item2;
  }

  Future<void> fetchRecentChapters() async {
    _recentChapters = null;
    _recentChaptersMangas = null;
    notifyListeners();

    _recentChapters =
        await ChaptersControllerHelper.getGeneralLatestChapter(http);
    notifyListeners();

    var ids = _recentChapters!
        .map((chapter) => chapter.relationships
            .singleWhere((element) => element!['type'] == "manga")!['id']
            .toString())
        .toList();
    notifyListeners();

    var mangas =
        await MangaControllerHelper.getMangasData(http, identificatiors: ids);

    Map<String, MangaModel> userManTemp = {};
    for (var i = 0; i < mangas.item1.length; i++) {
      Map<String, MangaModel> item = {};
      userManTemp["${mangas.item1[i].data.id}"] = mangas.item1[i];
    }
    _recentChaptersMangas = userManTemp;
    notifyListeners();
  }
}

class MangaControllerHelper {
  static Future<Tuple<List<MangaModel>, PaginationModel>> getMangasData(
    MangadexService http, {
    String limit = "20",
    String? title,
    List<String>? identificatiors,
    String order = "[createdAt]=desc",
  }) async {
    var link =
        "/manga?limit=$limit&order$order${title != null ? "&title=$title" : ""}";
    if (identificatiors != null) {
      int i = 0;
      for (var id in identificatiors) {
        link += "&ids[]=$id";
        i++;
      }
    }
    link = await ChaptersControllerHelper.getTContentRatingUrl(link);
    var response = await http.get(link);

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

  static Future<List<TagsModel>> getTags(MangadexService http) async {
    var response = await http.get("/manga/tag");

    List<TagsModel> tagList = [];

    for (dynamic tagItem in response.data) {
      tagList.add(TagsModel.fromJson(tagItem));
    }

    return tagList;
  }
}
