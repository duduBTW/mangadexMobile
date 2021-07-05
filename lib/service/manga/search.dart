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

enum PagesSearch { manga, author }

class SearchController with ChangeNotifier {
  late final MangadexService http;

  PagesSearch _currentPage = PagesSearch.manga;
  PagesSearch get currentPage => _currentPage;
  set currentPage(PagesSearch currentPage) {
    _currentPage = currentPage;
    notifyListeners();

    attSearchCurrentPage();
  }

  List<String> _includedTags = [];
  List<String> get includedTags => _includedTags;
  set includedTags(List<String> includedTags) {
    _includedTags = includedTags;
    notifyListeners();
  }

  void addTag(String id) {
    includedTags = [...includedTags, id];

    attSearchCurrentPage();
  }

  void removeTag(String id) {
    includedTags.remove(id);

    attSearchCurrentPage();
  }

  List<String> _excludedTags = [];
  List<String> get excludedTags => _excludedTags;
  set excludedTags(List<String> excludedTags) {
    _excludedTags = excludedTags;
    notifyListeners();
  }

  void addExcludedTag(String id) {
    excludedTags = [...excludedTags, id];

    attSearchCurrentPage();
  }

  void removeExcludedTag(String id) {
    excludedTags.remove(id);

    attSearchCurrentPage();
  }

  String _title = "";
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
    attSearchCurrentPage();
  }

  void attSearchCurrentPage() {
    switch (currentPage) {
      case PagesSearch.manga:
        getMangas();
        break;
      case PagesSearch.author:
        getAuthors();
        break;
      default:
        print("?? Current page unknown ??");
        break;
    }
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  List<TagsModel>? _allTags;
  List<TagsModel>? get allTags => _allTags;
  set allTags(List<TagsModel>? allTags) {
    _allTags = allTags;
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
    String includedTagsString = "";
    for (var includedTag in includedTags) {
      includedTagsString += "&includedTags[]=$includedTag";
    }

    String excludedTagsString = "";
    for (var excludedTag in excludedTags) {
      excludedTagsString += "&excludedTags[]=$excludedTag";
    }
    var res = await MangaControllerHelper.getMangasData(http,
        title: title,
        includedTags: includedTagsString,
        excludedTags: excludedTagsString);

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
    allTags = res;

    tags = res.groupBy((m) => m.data.attributes.group);
  }
}
