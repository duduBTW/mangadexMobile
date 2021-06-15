import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/index.dart';
import 'package:mangadex/service/cover/model/index.dart';

import '../http.dart';
import 'model/index.dart';

class MangaItemController with ChangeNotifier {
  late final MangadexService http;

  MangaItemController(this.http);

  MangaModel? _manga;
  MangaModel? get manga => _manga;
  set manga(MangaModel? manga) {
    _manga = manga;
    notifyListeners();
  }

  List<CoverModel>? _covers;
  List<CoverModel>? get covers => _covers;
  void updateCovers() async {
    if (_manga != null) {
      _covers =
          await CoverControllerHelper.getMangaCoversData(http, _manga!.data.id);
      notifyListeners();
    }
  }
  // set recentCovers(List<CoverModel>? recentCovers) {
  //   _covers = recentCovers;
  //   notifyListeners();
  // }
}
