import 'package:flutter/material.dart';

class HeaderManga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.favorite_border_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.mode_comment_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            width: 30,
          ),
          Container(
            height: 320,
            width: 226,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 16,
                    offset: Offset(4, 4), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment(0, -1),
                    image: NetworkImage(
                        "https://images.catmanga.org/series/tawawa/covers/01.jpeg"))),
          ),
        ],
      ),
    );
  }
}
