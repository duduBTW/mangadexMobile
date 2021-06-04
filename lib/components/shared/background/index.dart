import 'package:flutter/material.dart';
import 'package:mangadex/components/manga/background.dart';
import 'package:mangadex/components/manga/header.dart';
import 'package:mangadex/components/manga/info.dart';
import 'package:mangadex/components/shared/chapters/index.dart';

class BackgroundContainer extends StatefulWidget {
  final Widget content;
  final String backgroundImage;

  const BackgroundContainer(this.content, this.backgroundImage);

  @override
  _BackgroundContainerState createState() => _BackgroundContainerState();
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            child: BackgroundImageManga(widget.backgroundImage),
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
                widget.content,
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
