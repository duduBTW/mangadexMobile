import 'package:mangadex/service/cover/model/index.dart';
import 'package:mangadex/service/http.dart';

class ChaptersControllerHelper {
  static Future<CoverModel> getAggregate(
      MangadexService http, String id) async {
    var result = await http.get("/manga/$id/aggregate");

    return CoverModel.fromJson(result.data);
  }
}
