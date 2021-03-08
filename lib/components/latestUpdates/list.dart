import 'package:flutter/material.dart';

import 'manga.dart';

class ListMangasMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return MangaMainItem();
          },
          separatorBuilder: (_, __) => SizedBox(
                height: 30,
              ),
          itemCount: 3),
    );
  }
}
