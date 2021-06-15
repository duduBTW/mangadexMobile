import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/actions/button.dart';
import 'package:mangadex/service/manga/model/index.dart';

class HeaderManga extends StatelessWidget {
  final MangaModel manga;

  const HeaderManga({Key? key, required this.manga}) : super(key: key);

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
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
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
                ),
                SizedBox(
                  height: 60,
                ),
                ButtonAction(Icons.favorite),
                SizedBox(
                  height: 30,
                ),
                ButtonAction(Icons.more_horiz)
              ],
            ),
          )),
          SizedBox(
            width: 30,
          ),
          Container(
            width: 226,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
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
                    fit: BoxFit.cover,
                    alignment: Alignment(0, -1),
                    image: NetworkImage(manga.data.coverLink))),
          ),
        ],
      ),
    );
  }
}
