import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var gradiant = new LinearGradient(
    colors: [
      Colors.black.withOpacity(0.85),
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp);

var gradiantRev = new LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black.withOpacity(0.85),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp);

class CardListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
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
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://cdn.myanimelist.net/images/characters/8/311602.jpg")),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(7),
                    ),
                    gradient: gradiantRev),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          size: 12,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "10.000",
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).accentColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "4.2",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 63,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(7),
                    ),
                    gradient: gradiant),
                child: Text(
                  "Kemono Jihen",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
