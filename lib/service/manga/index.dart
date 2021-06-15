import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/shared/pagination/index.dart';
import 'dart:core';

import 'package:mangadex/service/shared/tuple/index.dart';

class MangaController with ChangeNotifier {
  late final MangadexService http;

  MangaController(this.http);

  List<MangaModel>? _recentMangas;
  List<MangaModel>? _userMangas;

  List<MangaModel>? get recentMangas => _recentMangas;
  List<MangaModel>? get userMangas => _userMangas;

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
      const int PERPAGE = 30;

      var result = await MangaControllerHelper.getUserMangasData(http,
          limit: PERPAGE * (pageKey + 1), offset: PERPAGE * pageKey);
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

  Future<PaginationModel> getRecentMangas() async {
    // _recentMangas = await MangaControllerHelper.getRecentMangasData(http)..item1;
    var recentMangaResult =
        await MangaControllerHelper.getRecentMangasData(http);
    _recentMangas = recentMangaResult.item1;
    notifyListeners();

    return recentMangaResult.item2;
  }

  Future<PaginationModel> getUserMangas() async {
    var userMangaResult = await MangaControllerHelper.getUserMangasData(http);
    // _userMangas = userMangaResult.item1;
    // notifyListeners();

    return userMangaResult.item2;
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
