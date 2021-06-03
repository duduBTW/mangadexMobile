import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaMainItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/title"),
      child: Container(
        height: 100,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.catmanga.org/series/tawawa/covers/01.jpeg"))),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "My New Wife Is Forcing Herself to Smile",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Chapter 32",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 12),
                                ),
                                // Image.network(
                                //   "",
                                //   height: 12,
                                //   width: 19,
                                //   fit: BoxFit.cover,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 1,
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
                                  "SleepySlimeTL",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  "4 hrs ago",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
