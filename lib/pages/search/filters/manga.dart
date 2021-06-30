import 'package:flutter/material.dart';
import 'package:mangadex/service/manga/model/tags/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:provider/provider.dart';

class MangaFilters extends StatefulWidget {
  const MangaFilters({Key? key}) : super(key: key);

  @override
  _MangaFiltersState createState() => _MangaFiltersState();
}

class _MangaFiltersState extends State<MangaFilters> {
  @override
  void initState() {
    super.initState();
    Provider.of<SearchController>(context, listen: false).getTags();
  }

  @override
  Widget build(BuildContext context) {
    var tags = Provider.of<SearchController>(context).tags;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Filters"),
      ),
      body: tags == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tags['format'] != null)
                      TagSelect(
                        label: "Format",
                        tags: tags['format']!,
                      ),
                    if (tags['genre'] != null)
                      TagSelect(
                        label: "Genre",
                        tags: tags['genre']!,
                      ),
                    if (tags['theme'] != null)
                      TagSelect(
                        label: "Theme",
                        tags: tags['theme']!,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

class TagSelect extends StatelessWidget {
  final List<TagsModel> tags;
  final String label;
  final bool selected;
  const TagSelect(
      {Key? key,
      required this.tags,
      required this.label,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            ...tags
                .map((tag) => TagFilterItem(
                      selected: selected,
                      tagTitle: tag.data.attributes.name['en'] ?? "",
                    ))
                .toList()
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class TagFilterItem extends StatelessWidget {
  const TagFilterItem({
    Key? key,
    required this.selected,
    required this.tagTitle,
  }) : super(key: key);

  final String tagTitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.5))),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(tagTitle,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  fontSize: 12)),
        ),
      ),
    );
  }
}
