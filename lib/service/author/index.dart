import 'package:mangadex/service/author/model/index.dart';

import '../http.dart';

class AuthorControllerHelper {
  static Future<List<AuthorModel>> getAuthors(MangadexService http,
      {String? title}) async {
    var response = await http.get("/author", queryParameters: {"name": title});

    List<AuthorModel> authorList = [];

    for (dynamic authorItem in response.data['results']) {
      authorList.add(AuthorModel.fromJson(authorItem));
    }

    return authorList;
  }
}
