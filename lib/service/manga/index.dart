import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/service/chapters/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/scan/index.dart';
import 'package:mangadex/service/scan/model/index.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'package:mangadex/service/shared/tuple/index.dart';

import 'model/tags/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();

  MangaController(this.http);

  List<MangaModel>? _recentMangas;

  List<MangaModel>? get recentMangas => _recentMangas;

  // Recent
  final _recentChapterPageController = PagingController<int, ChapterModel>(
    firstPageKey: 0,
  );
  PagingController<int, ChapterModel> get chapterPageController =>
      _recentChapterPageController;

  void initRecentCahpters() {
    _recentChapterPageController.addPageRequestListener((pageKey) {
      fetchRecentChapters(pageKey);
    });

    // fetchRecentChapters(0);
  }

  List<ChapterModel>? _recentChapters;
  List<ChapterModel>? get recentChapters => _recentChapters;

  Map<String, MangaModel>? _recentChaptersMangas;
  Map<String, MangaModel>? get recentChaptersMangas => _recentChaptersMangas;

  Map<String, ScanlationGroupDataModel>? _recentChaptersScans;
  Map<String, ScanlationGroupDataModel>? get recentChaptersScans =>
      _recentChaptersScans;

  Future<void> fetchRecentChapters(int pageKey) async {
    try {
      int perpage =
          int.parse(await storage.read(key: "DEF_LOAD_COUNT") ?? "30");

      notifyListeners();

      var result = await ChaptersControllerHelper.getGeneralLatestChapter(http,
          limit: perpage * (pageKey + 1), offset: perpage * pageKey);

      var pageResult = result.item2;
      var mangas = result.item1;

      final previouslyFetchedItemsCount =
          _recentChapterPageController.itemList?.length ?? 0;
      final totalFetchedItemsCount =
          previouslyFetchedItemsCount + mangas.length;
      final isLastPage = totalFetchedItemsCount == pageResult.total;
      if (isLastPage) {
        _recentChapterPageController.appendLastPage(mangas);
      } else {
        final nextPageKey = pageKey + 1;
        _recentChapterPageController.appendPage(mangas, nextPageKey);
      }

      updateChapMangas(result.item1);
      updateChapScans(result.item1);
    } catch (error) {
      _recentChapterPageController.error = error;
      throw error;
    }
  }

  // - // - // - // - //

  Future<PaginationModel> getRecentMangas() async {
    _recentMangas = null;

    var recentMangaResult = await MangaControllerHelper.getMangasData(http);
    _recentMangas = recentMangaResult.item1;
    notifyListeners();

    return recentMangaResult.item2;
  }

  void updateChapMangas(List<ChapterModel> data) async {
    var ids = MangaControllerHelper.findRelationship("manga", data);

    var userManTemp = await MangaControllerHelper.getMangaChapters(http, ids);
    _recentChaptersMangas = _recentChaptersMangas != null
        ? {..._recentChaptersMangas!, ...userManTemp}
        : userManTemp;
    notifyListeners();
  }

  void updateChapScans(List<ChapterModel> data) async {
    var idsScan =
        MangaControllerHelper.findRelationship("scanlation_group", data);

    var recentChaptersScansTemp =
        await MangaControllerHelper.getMangaGroups(http, idsScan);

    _recentChaptersScans = _recentChaptersScans != null
        ? {..._recentChaptersScans!, ...recentChaptersScansTemp}
        : recentChaptersScansTemp;

    notifyListeners();
  }
}

class MangaControllerHelper {
  static List<String> findRelationship(
      String relation, List<ChapterModel> data) {
    List<String> ids = [];
    for (var chapter in data) {
      var idsTemp = chapter.relationships
          .where((element) => element!['type'] == relation);

      ids = [...ids, ...idsTemp.map((id) => id!['id']).toList()];
    }

    return ids;
  }

  static Future<Map<String, ScanlationGroupDataModel>> getMangaGroups(
      MangadexService http, List<String> ids) async {
    var scans =
        await ScanlationGroupDataControllerHelper.getScans(http, ids: ids);

    Map<String, ScanlationGroupDataModel> _userChaptersScansTemp = {};
    for (var i = 0; i < scans.length; i++) {
      _userChaptersScansTemp["${scans[i].id}"] = scans[i];
    }

    return _userChaptersScansTemp;
  }

  static Future<Map<String, MangaModel>> getMangaChapters(
      MangadexService http, List<String> ids) async {
    var mangas = await MangaControllerHelper.getMangasData(http,
        identificatiors: ids,
        limit: ids.length.toString(),
        considerContentRating: false);

    Map<String, MangaModel> userManTemp = {};
    for (var i = 0; i < mangas.item1.length; i++) {
      userManTemp["${mangas.item1[i].data.id}"] = mangas.item1[i];
    }
    return userManTemp;
  }

  static Future<Tuple<List<MangaModel>, PaginationModel>> getMangasData(
      MangadexService http,
      {String limit = "20",
      String? title,
      List<String>? identificatiors,
      String order = "[createdAt]=desc",
      String includedTags = "",
      String excludedTags = "",
      bool considerContentRating = true}) async {
    var link =
        "/manga?limit=$limit&order$order${title != null ? "&title=$title" : ""}";
    link = link += includedTags + excludedTags;
    if (identificatiors != null) {
      for (var id in identificatiors) {
        link += "&ids[]=$id";
      }
    }
    if (considerContentRating) {
      link = await ChaptersControllerHelper.getTContentRatingUrl(link);
    }
    var response = await http.get(link);

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

  static Future<MangaModel> getSingleManga(
      MangadexService http, MangaModel manga) async {
    var link =
        "/manga/${manga.data.id}?includes[]=artist&includes[]=author&includes[]=cover_art";
    var response = await http.get(link);

    return MangaModel.fromJson(response.data);
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
