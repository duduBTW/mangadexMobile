import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/chapters/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/cover/model/index.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:mangadex/service/scan/model/index.dart';

import '../http.dart';
import 'model/index.dart';

enum ReagingDirection {
  leftToRight,
  RightToLeft,
}

enum PageFit {
  width,
  height,
}

class MangaItemController with ChangeNotifier {
  late final MangadexService http;
  static final storage = new FlutterSecureStorage();

  MangaItemController(this.http);

  // Configuration
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

    var newValueZoom = await storage.read(key: 'DEF_READ_ZOOM');

    if (newValueZoom != null) {
      zoom = newValueZoom == "1";
      return;
    }

    if (selected != "Swipe") {
      zoom = true;
    }
  }

  //Direction
  ReagingDirection _direction = ReagingDirection.leftToRight;
  ReagingDirection get direction => _direction;
  set direction(ReagingDirection direction) {
    _direction = direction;
    notifyListeners();
  }

  //Zoom
  bool _zoom = true;
  bool get zoom => _zoom;
  set zoom(bool zoom) {
    _zoom = zoom;
    notifyListeners();
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
    getSingleManga(manga);
  }

  void getSingleManga(MangaModel? newManga) async {
    if (newManga != null) {
      _manga = await MangaControllerHelper.getSingleManga(http, newManga);
      notifyListeners();
    }
  }

  Map<String, List<ChapterModel>> _chapter = {};
  Map<String, List<ChapterModel>> get chapter => _chapter;

  List<String> _chaptersList = [];
  List<String> get chaptersList => _chaptersList;
  set chaptersList(List<String> chaptersList) {
    _chaptersList = chaptersList;
    notifyListeners();
  }

  Map<String, ScanlationGroupDataModel>? _chaptersScans;
  Map<String, ScanlationGroupDataModel>? get chaptersScans => _chaptersScans;

  void updateChapScans(List<ChapterModel> data) async {
    var idsScan =
        MangaControllerHelper.findRelationship("scanlation_group", data);

    var chaptersScansTemp =
        await MangaControllerHelper.getMangaGroups(http, idsScan);

    _chaptersScans = _chaptersScans != null
        ? {..._chaptersScans!, ...chaptersScansTemp}
        : chaptersScansTemp;

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
    var chaptersTemp =
        await ChaptersControllerHelper.getChapter(http, _manga!.data.id, id);
    _chapter[id] = chaptersTemp;

    notifyListeners();
    updateChapScans(chaptersTemp);
  }

  void getNextChapter() async {
    print(_chaptersList.indexOf(chapterReadingNow));
    var index = _chaptersList.indexOf(chapterReadingNow);
    // var beforeCalc = _chaptersList[index + 1];
    var nextCalc = _chaptersList[index - 1];

    next = nextCalc;
    // before = beforeCalc;

    notifyListeners();
    getChapter(nextCalc);
    // getChapter(beforeCalc);
  }

  void updateServer(String idChap) async {
    _serverUrl = await ChaptersControllerHelper.getServer(http, idChap);
    notifyListeners();
  }
}
