import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:provider/provider.dart';

class Follows extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  Follows({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Follows> {
  @override
  void initState() {
    super.initState();
    Provider.of<MangaController>(context, listen: false).getUserMangas();
  }

  @override
  Widget build(BuildContext context) {
    var mangas = Provider.of<MangaController>(context).userMangas;

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                    backgroundColor: Colors.transparent,
                    radius: 15.0,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "My mangas",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Followed Feed",
                ),
                Tab(
                  text: "Follows",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              // padding: const EdgeInsets.symmetric(vertical: 30),
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: mangas?.length != null ? mangas!.length : 0,
                itemBuilder: (ctx, index) => MangaShow(mangas![index]),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
              ),
            ),
            Container()
          ]),
        ),
      ),
    );
  }
}