import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';

import 'horizontalCards/index.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverAppBar(
          actions: [Container()],
          automaticallyImplyLeading: false,
          // Provide a standard title.
          title: Row(
            children: [
              GestureDetector(
                // onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                  backgroundColor: Colors.transparent,
                  radius: 15.0,
                ),
              ),
            ],
          ),
          floating: true,
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Featured",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CardListHorizontal(),
              ),
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: "manga-list",
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Latest Updated",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            "See all",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: "a-list",
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recently Added",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            "See all",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}
