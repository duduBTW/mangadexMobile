import 'package:flutter/material.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/index.dart';

import 'model/index.dart';

class SearchController with ChangeNotifier {
  late final MangadexService http;
  String _title = "";
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

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
    loading = true;
    var res = await MangaControllerHelper.getMangasData(http, title: title);

    _mangas = res.item1;
    _loading = false;
    notifyListeners();
  }
}
