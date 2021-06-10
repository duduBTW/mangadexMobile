import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';

class Follows extends StatelessWidget {
  const Follows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(
                text: "Followed Feed",
              ),
              Tab(
                text: "Follows",
              ),
            ],
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container()
          ]),
        ),
      ),
    );
  }
}
