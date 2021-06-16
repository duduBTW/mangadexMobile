import 'dart:core';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/model/index.dart';

import 'index.dart';

class UserMangaController with ChangeNotifier {
  late final MangadexService http;

  UserMangaController(this.http);

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
}
