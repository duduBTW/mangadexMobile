import 'package:flutter/material.dart';

import 'RowInfo.dart';
import 'info.dart';

class MangaHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          height: 90,
          child: Row(
            children: [
              Container(
                width: 60,
                height: 90,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage("Senpai.jpg"))),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowInfo(
                    label: "Title ID",
                    value: "# 23825",
                  ),
                  RowInfo(
                    label: "Author",
                    value: "Shiro Manta",
                  ),
                  RowInfo(
                    label: "Artist",
                    value: "Shiro Manta",
                  ),
                  RowInfo(
                    label: "Pub. status",
                    value: "Ongoing",
                  )
                ],
              ))
            ],
          ),
        ),
        InfoManga()
      ],
    );
  }
}
