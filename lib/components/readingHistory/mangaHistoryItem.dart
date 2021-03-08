import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/title"),
      child: Container(
        height: 60,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("teste1MangaCover.jpg"))),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Boku no Kokoro no Yabai Yatsu",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(2)),
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chapter 65.3",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 8),
                          ),
                          Text(
                            "17 hrs ago",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 8),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
