import 'package:flutter/material.dart';
import 'package:mangadex/components/manga/background.dart';
import 'package:mangadex/components/manga/header.dart';
import 'package:mangadex/components/manga/info.dart';
import 'package:mangadex/components/shared/chapters/index.dart';

class MangaPage extends StatefulWidget {
  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  ScrollController _controller = new ScrollController();
  bool _showNav = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(onScroll);
  }

  void onScroll() {
    if (_controller.position.pixels > 700 && !_showNav) {
      setState(() {
        _showNav = true;
      });

      return;
    }

    if (_controller.position.pixels < 700 && _showNav) {
      setState(() {
        _showNav = false;
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _showNav
            ? AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).accentColor,
                title: Text(
                  "Getsuyoubi no Tawawa (Blue)",
                  style: Theme.of(context).textTheme.headline3,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  )
                ],
              )
            : null,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                child: BackgroundImageManga(
                    "https://images.catmanga.org/series/tawawa/chapters/1/007.png"),
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
              ),
              Positioned(
                child: BackgroundGradientManga(),
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
              ),
              SingleChildScrollView(
                controller: _controller,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Stack(
                  children: [
                    Positioned(
                      child: BackgroundManga(Theme.of(context).primaryColor),
                      top: 141,
                      left: 0,
                      right: 0,
                      bottom: 0,
                    ),
                    Positioned(
                      child: BackgroundManga(Theme.of(context).accentColor),
                      top: 145,
                      left: 0,
                      right: 0,
                      bottom: 0,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        HeaderManga(),
                        MangaInfo(),
                        Chapters()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
