import 'package:flutter/material.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/index.dart';

import 'model/index.dart';

class SearchController with ChangeNotifier {
  late final MangadexService http;
  String _title = "";

  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();

    getMangas();
  }

  SearchController(this.http);

  List<MangaModel>? _mangas;
  List<MangaModel>? get mangas => _mangas;

  void getMangas() async {
    var res = await MangaControllerHelper.getMangasData(http, title: title);

    _mangas = res.item1;
    notifyListeners();
  }
}
