import 'package:flutter/material.dart';
import 'package:mangadex/pages/search/filters/manga.dart';

class ConfigurationFilters extends StatelessWidget {
  final List<String> tags = [
    "Safe content",
    "Suggestive content",
    "Erotica content",
    "Pornographic content"
  ];
  ConfigurationFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Content Filter"),
      ),
      body: Wrap(
        direction: Axis.horizontal,
        children: [
          ...tags
              .map((tag) => TagFilterItem(
                    tagTitle: tag,
                  ))
              .toList()
        ],
      ),
    );
  }
}
