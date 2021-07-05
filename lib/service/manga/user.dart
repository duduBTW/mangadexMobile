import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/service/chapters/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/scan/index.dart';
import 'package:mangadex/service/scan/model/index.dart';

import 'index.dart';

class UserMangaController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();

  UserMangaController(this.http);

  // Chap Scans
  Map<String, ScanlationGroupDataModel>? _userChaptersScans;
  Map<String, ScanlationGroupDataModel>? get userChaptersScans =>
      _userChaptersScans;
  set userChaptersScans(
      Map<String, ScanlationGroupDataModel>? userChaptersScans) {
    _userChaptersScans = userChaptersScans;
    notifyListeners();
  }
  // - // - // - // - //

  List<MangaModel>? _recentMangas;

  List<MangaModel>? _userMangas;

  List<ChapterModel>? _userChapters;
  Map<String, MangaModel>? _userChaptersMangas;

  Map<String, MangaModel>? get userChaptersMangas => _userChaptersMangas;

  List<ChapterModel>? get userChapters => _userChapters;
  List<MangaModel>? get recentMangas => _recentMangas;
  List<MangaModel>? get userMangas => _userMangas;

  Future<void> fetchChapters() async {
    var chaps = await ChaptersControllerHelper.getLatestChapter(http);

    _userChapters = chaps.item1;
    notifyListeners();

    var ids = _userChapters!
        .map((chapter) => chapter.relationships
            .singleWhere((element) => element!['type'] == "manga")!['id']
            .toString())
        .toList();

    var mangas =
        await MangaControllerHelper.getMangasData(http, identificatiors: ids);

    Map<String, MangaModel> userManTemp = {};
    for (var i = 0; i < mangas.item1.length; i++) {
      Map<String, MangaModel> item = {};
      userManTemp["${mangas.item1[i].data.id}"] = mangas.item1[i];
    }
    _userChaptersMangas = userManTemp;
    notifyListeners();
  }

  /////////
  final _pagingController = PagingController<int, MangaModel>(
    firstPageKey: 0,
  );
  PagingController<int, MangaModel> get pagingController => _pagingController;

  void initUserMangas() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      int perpage =
          int.parse(await storage.read(key: "DEF_LOAD_COUNT") ?? "30");

      var result = await MangaControllerHelper.getUserMangasData(http,
          limit: perpage * (pageKey + 1), offset: perpage * pageKey);
      var pageResult = result.item2;
      var mangas = result.item1;

      final previouslyFetchedItemsCount =
          // 2
          _pagingController.itemList?.length ?? 0;
      final totalFetchedItemsCount =
          previouslyFetchedItemsCount + mangas.length;
      final isLastPage = totalFetchedItemsCount == pageResult.total;

      if (isLastPage) {
        // 3
        _pagingController.appendLastPage(mangas);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(mangas, nextPageKey);
      }
    } catch (error) {
      // 4
      _pagingController.error = error;
      throw error;
    }
  }
  /////////

  /////////
  final _chapterPageController = PagingController<int, ChapterModel>(
    firstPageKey: 0,
  );
  PagingController<int, ChapterModel> get chapterPageController =>
      _chapterPageController;

  void initUserCahpters() {
    _chapterPageController.addPageRequestListener((pageKey) {
      _fetchChapterPage(pageKey);
    });
  }

  Future<void> _fetchChapterPage(int pageKey) async {
    try {
      int perpage =
          int.parse(await storage.read(key: "DEF_LOAD_COUNT") ?? "30");

      var result = await ChaptersControllerHelper.getLatestChapter(http,
          limit: perpage * (pageKey + 1), offset: perpage * pageKey);

      var pageResult = result.item2;
      var chapters = result.item1;

      final previouslyFetchedItemsCount =
          _chapterPageController.itemList?.length ?? 0;
      final totalFetchedItemsCount =
          previouslyFetchedItemsCount + chapters.length;
      final isLastPage = totalFetchedItemsCount == pageResult.total;

      if (isLastPage) {
        _chapterPageController.appendLastPage(chapters);
      } else {
        final nextPageKey = pageKey + 1;
        _chapterPageController.appendPage(chapters, nextPageKey);
      }

      var ids = result.item1
          .map((chapter) => chapter.relationships
              .singleWhere((element) => element!['type'] == "manga")!['id']
              .toString())
          .toList();

      ids = ids.toSet().toList();
      updateMangaChapters(ids);

      List<String> idsScan = [];
      for (var chapter in result.item1) {
        var ids = chapter.relationships
            .where((element) => element!['type'] == "scanlation_group");

        idsScan = [...idsScan, ...ids.map((id) => id!['id']).toList()];
      }
      updateMangaGroups(idsScan);
      // String? id = result.item1[9].relationships.where(
      //     (element) => element?['type'] == "scanlation_group")?['id'];

      // if (id != null) {
      //   idsScan = [...idsScan, id];
      // }

      // var teste = idsScan;

      // var idsScan = result.item1.map((chapter) => chapter.relationships
      // .singleWhere(
      //     (element) => element?['type'] == "scanlation_group")!['id']
      //     .toString());

      // var teste = idsScan.toList();

      // var idsScan = result.item1
      //     .map((chapter) => chapter.relationships
      //         .singleWhere(
      //             (element) => element?['type'] == "scanlation_group")!['id']
      //         .toString())
      //     .toList();

      // idsScan = idsScan.toSet().toList();
      // updateMangaGroups(idsScan);
    } catch (error) {
      _chapterPageController.error = error;
      throw error;
    }
  }

  void updateMangaGroups(List<String> ids) async {
    var scans =
        await ScanlationGroupDataControllerHelper.getScans(http, ids: ids);

    Map<String, ScanlationGroupDataModel> _userChaptersScansTemp = {};
    for (var i = 0; i < scans.length; i++) {
      _userChaptersScansTemp["${scans[i].id}"] = scans[i];
    }
    _userChaptersScans = _userChaptersScans != null
        ? {..._userChaptersScans!, ..._userChaptersScansTemp}
        : _userChaptersScansTemp;
    notifyListeners();
  }

  void updateMangaChapters(List<String> ids) async {
    var mangas = await MangaControllerHelper.getMangasData(http,
        identificatiors: ids,
        limit: ids.length.toString(),
        considerContentRating: false);

    Map<String, MangaModel> userManTemp = {};
    for (var i = 0; i < mangas.item1.length; i++) {
      userManTemp["${mangas.item1[i].data.id}"] = mangas.item1[i];
    }
    _userChaptersMangas = _userChaptersMangas != null
        ? {..._userChaptersMangas!, ...userManTemp}
        : userManTemp;
    notifyListeners();
  }
  /////////
}
