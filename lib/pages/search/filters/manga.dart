import 'package:flutter/material.dart';
import 'package:mangadex/components/home/search/index.dart';

class MangaFilters extends StatelessWidget {
  const MangaFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchInput(() => {}, () => {}),
        ],
      ),
    );
  }
}
