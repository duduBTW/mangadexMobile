import 'package:flutter/material.dart';
import 'package:mangadex/components/ShowTitles/index.dart';
import 'package:mangadex/components/latestUpdates/index.dart';
import 'package:mangadex/components/readingHistory/index.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [LatestuUpdates(), ReadingHistory(), ShowTitles()],
          ),
        ),
      ),
    );
  }
}
