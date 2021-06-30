import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/manga/user.dart';
import 'package:provider/provider.dart';

class FollowsMangas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _pagingController =
        Provider.of<UserMangaController>(context).pagingController;

    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () => Future.sync(
        () {
          _pagingController.refresh();
        },
      ),
      // padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: PagedListView(
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
              newPageProgressIndicatorBuilder: (_) => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                    ),
                  )),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }
}
