import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/model/index.dart';

import '../http.dart';

class CoverController with ChangeNotifier {
  late final MangadexService http;
  List<CoverModel>? _recentCovers;

  List<CoverModel>? get recentCovers => _recentCovers;

  set recentCovers(List<CoverModel>? recentCovers) {
    _recentCovers = recentCovers;
    notifyListeners();
  }

  CoverController(this.http);
}

class CoverControllerHelper {
  static Future<List<CoverModel>> getCoversData(
      MangadexService http, List<String> ids) async {
    String link = "/cover?";

    int i = 0;
    for (var id in ids) {
      if (i == 0) {
        link += "manga[]=$id";
      } else {
        link += "&manga[]=$id";
      }
      i++;
    }

    link += "&limit=20";
    print(link);

    var response = await http.get(link);

    List<CoverModel> covers = [];

    for (dynamic coverItemApi in response.data['results']) {
      covers.add(CoverModel.fromJson(coverItemApi));
    }

    return covers;
  }
}
