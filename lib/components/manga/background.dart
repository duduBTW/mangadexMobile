import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundManga extends StatelessWidget {
  final double radius = 30;
  final Color color;

  BackgroundManga(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
              topLeft: Radius.circular(radius))),
    );
  }
}

class BackgroundImageManga extends StatelessWidget {
  final double radius = 30;
  final String? imageLink;

  BackgroundImageManga(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment(0, -1),
              image: imageLink != null
                  ? NetworkImage(imageLink!)
                  : AssetImage("assets/noPfp.png") as ImageProvider),
        ),
      ),
    );
  }
}

class BackgroundGradientManga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 0.4, 0.9],
        colors: [
          Colors.white.withOpacity(0.75),
          Colors.white,
          Theme.of(context).accentColor
        ],
      )),
    );
  }
}
