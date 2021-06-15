import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:provider/provider.dart';

class FollowsMangas extends StatefulWidget {
  const FollowsMangas({Key? key}) : super(key: key);

  @override
  _FollowsMangasState createState() => _FollowsMangasState();
}

class _FollowsMangasState extends State<FollowsMangas> {
  // final _pagingController = PagingController<int, MangaModel>(
  //   firstPageKey: 1,
  // );

  @override
  void initState() {
    super.initState();
    Provider.of<MangaController>(context, listen: false).initUserMangas();
  }

  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     var result = await Provider.of<MangaController>(context, listen: false)
  //         .getUserMangas();
  //     print("result: ");
  //     print(result.limit);
  //     print(result.offset);
  //     print(result.total);
  //   } catch (error) {
  //     // 4
  //     _pagingController.error = error;
  //     throw error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var _pagingController =
        Provider.of<MangaController>(context).pagingController;

    return Container(
      height: MediaQuery.of(context).size.height,
      // padding: const EdgeInsets.symmetric(vertical: 30),
      child: PagedListView(
        // shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MangaModel>(
          itemBuilder: (context, itemManga, index) => MangaShow(itemManga),
          firstPageErrorIndicatorBuilder: (context) => Container(
            height: 100,
            width: 100,
            child: Text(":( error"),
          ),
          noItemsFoundIndicatorBuilder: (context) => Container(
            height: 100,
            width: 100,
            child: Text(":("),
          ),
        ),
        // itemCount: mangas?.length != null ? mangas!.length : 0,
        // itemBuilder: (ctx, index) => MangaShow(mangas![index]),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
      ),
    );
  }
}
