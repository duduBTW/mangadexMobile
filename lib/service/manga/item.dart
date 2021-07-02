import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/chapters/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/cover/model/index.dart';

import '../http.dart';
import 'model/index.dart';

class MangaItemController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();

  MangaItemController(this.http);

  // Manga reader mode
  String? _selected;
  String? get selected => _selected;
  set selected(String? selected) {
    _selected = selected;
    notifyListeners();
  }

  void getDefData() async {
    var newValue = await storage.read(key: 'DEF_READ_TYPE');

    if (newValue != null) {
      selected = newValue;
      return;
    }

    selected = "Standard";
  }
  ////

  String? _serverUrl;
  String? get serverUrl => _serverUrl;

  MangaModel? _manga;
  MangaModel? get manga => _manga;
  set manga(MangaModel? manga) {
    _manga = manga;
    notifyListeners();

    getChapters();
  }

  Map<String, List<ChapterModel>> _chapter = {};
  Map<String, List<ChapterModel>> get chapter => _chapter;

  List<String> _chaptersList = [];
  List<String> get chaptersList => _chaptersList;
  set chaptersList(List<String> chaptersList) {
    _chaptersList = chaptersList;
    notifyListeners();
  }

  String chapterReadingNow = "";
  String next = "";
  String before = "";

  List<CoverModel>? _covers;
  List<CoverModel>? get covers => _covers;
  void updateCovers() async {
    if (_manga != null) {
      _covers =
          await CoverControllerHelper.getMangaCoversData(http, _manga!.data.id);
      notifyListeners();
    }
  }

  void getChapters() async {
    chaptersList = [];
    if (_manga != null) {
      List<String> chaps = [];
      var mangaAggregate =
          await ChaptersControllerHelper.getAggregate(http, _manga!.data.id);

      for (var volume in mangaAggregate.volumes.keys) {
        print("volume: $volume");

        if (mangaAggregate.volumes[volume]?.chapters != null) {
          for (var chapter in mangaAggregate.volumes[volume]!.chapters.keys) {
            if (mangaAggregate.volumes[volume]?.chapters[chapter]?.chapter !=
                null)
              chaps.add(
                  mangaAggregate.volumes[volume]!.chapters[chapter]!.chapter);
          }
        }
      }

      chaps = chaps.toSet().toList();
      chaps.sort(
          (v2, v1) => double.parse(v1).compareTo(double.tryParse(v2) ?? 0));

      chaptersList = chaps;
    }
  }

  Future<List<String>> getChaptersReturn(String id) async {
    chaptersList = [];
    if (_manga != null) {
      List<String> chaps = [];
      var mangaAggregate =
          await ChaptersControllerHelper.getAggregate(http, id);

      for (var volume in mangaAggregate.volumes.keys) {
        print("volume: $volume");

        if (mangaAggregate.volumes[volume]?.chapters != null) {
          for (var chapter in mangaAggregate.volumes[volume]!.chapters.keys) {
            if (mangaAggregate.volumes[volume]?.chapters[chapter]?.chapter !=
                null)
              chaps.add(
                  mangaAggregate.volumes[volume]!.chapters[chapter]!.chapter);
          }
        }
      }

      chaps = chaps.toSet().toList();
      chaps.sort((v2, v1) => double.parse(v1).compareTo(double.parse(v2)));

      return chaps;
    }

    return [];
  }

  void getChapter(String id) async {
    _chapter[id] =
        await ChaptersControllerHelper.getChapter(http, _manga!.data.id, id);
    notifyListeners();
  }

  void getNextChapter() async {
    print(_chaptersList.indexOf(chapterReadingNow));
    var index = _chaptersList.indexOf(chapterReadingNow);
    var beforeCalc = _chaptersList[index + 1];
    var nextCalc = _chaptersList[index - 1];

    next = nextCalc;
    before = beforeCalc;

    notifyListeners();
    getChapter(nextCalc);
    getChapter(beforeCalc);
  }

  void updateServer(String idChap) async {
    _serverUrl = await ChaptersControllerHelper.getServer(http, idChap);
    notifyListeners();
  }
}
