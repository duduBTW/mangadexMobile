import 'package:flutter/material.dart';
import 'package:mangadex/service/author/index.dart';
import 'package:mangadex/service/author/model/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/manga/index.dart';

import 'model/index.dart';
import 'model/tags/index.dart';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

class SearchController with ChangeNotifier {
  late final MangadexService http;
  String _title = "";
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();

    getMangas();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Map<String, List<TagsModel>>? _tags;
  Map<String, List<TagsModel>>? get tags => _tags;
  set tags(Map<String, List<TagsModel>>? tags) {
    _tags = tags;
    notifyListeners();
  }

  // Author
  bool _loadingAuthor = false;
  bool get loadingAuthor => _loadingAuthor;
  set loadingAuthor(bool loadingAuthor) {
    _loadingAuthor = loadingAuthor;
    notifyListeners();
  }

  List<AuthorModel>? _authors;
  List<AuthorModel>? get authors => _authors;
  set authors(List<AuthorModel>? authors) {
    _authors = authors;
    notifyListeners();
  }

  // // //
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

  void getAuthors() async {
    loadingAuthor = true;
    var res = await AuthorControllerHelper.getAuthors(http, title: title);

    print(res);

    _authors = res;
    _loadingAuthor = false;
    notifyListeners();
  }

  void getTags() async {
    var res = await MangaControllerHelper.getTags(http);
    tags = res.groupBy((m) => m.data.attributes.group);
  }
}
