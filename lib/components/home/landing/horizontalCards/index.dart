import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var gradiant = new LinearGradient(
    colors: [
      Colors.black.withOpacity(0.6),
      Colors.transparent,
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 0.3, 1.0],
    tileMode: TileMode.clamp);

class CardListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return CardManga();
          },
          separatorBuilder: (_, __) => SizedBox(
                width: 30,
              ),
          itemCount: 10),
    );
  }
}

class CardManga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 170,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://cdn.myanimelist.net/images/characters/8/311602.jpg")),
              // color: Colors.red,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Text(
              "Kemono Jihen teste aa",
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
