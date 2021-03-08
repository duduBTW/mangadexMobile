import 'package:flutter/material.dart';

import 'mangaHistoryItem.dart';

class ListHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return MangaHistoryItem();
          },
          separatorBuilder: (_, __) => SizedBox(
                height: 30,
              ),
          itemCount: 3),
    );
  }
}
