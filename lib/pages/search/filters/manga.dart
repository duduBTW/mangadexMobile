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
    var title = Provider.of<SearchController>(context).title;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Filters - $title"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: tags == null
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
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
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.height * .2) + 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * .2,
                      child: Row(
                        children: [
                          IncludedTags(),
                          Container(
                            height: double.infinity,
                            width: 1,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                          ExcludedTags(),
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}

class IncludedTags extends StatelessWidget {
  const IncludedTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tags = Provider.of<SearchController>(context).includedTags;
    var allTags = Provider.of<SearchController>(context).allTags;

    return Expanded(
      child: DragTarget<String>(
        onAccept: (data) =>
            Provider.of<SearchController>(context, listen: false).addTag(data),
        builder: (
          BuildContext context,
          accepted,
          rejected,
        ) =>
            Container(
          decoration: BoxDecoration(
            color: accepted.isNotEmpty ? Colors.grey[100] : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Included Tags",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 15,
                ),
                if (tags.length <= 0)
                  Text(
                    "Drag and drop Tags here",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ...tags
                    .map((tag) => TagFilterItem(
                        onTap: () => Provider.of<SearchController>(context,
                                listen: false)
                            .removeTag(tag),
                        tagTitle: allTags!
                                .firstWhere((allTag) => allTag.data.id == tag)
                                .data
                                .attributes
                                .name['en'] ??
                            ""))
                    .toList(),
                SizedBox(
                  height: 15,
                ),
                if (tags.length > 0)
                  Text(
                    "Tap to delete",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                if (tags.length > 0)
                  SizedBox(
                    height: 15,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExcludedTags extends StatelessWidget {
  const ExcludedTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tags = Provider.of<SearchController>(context).excludedTags;
    var allTags = Provider.of<SearchController>(context).allTags;

    return Expanded(
      child: DragTarget<String>(
        onAccept: (data) =>
            Provider.of<SearchController>(context, listen: false)
                .addExcludedTag(data),
        builder: (
          BuildContext context,
          accepted,
          rejected,
        ) =>
            Container(
          decoration: BoxDecoration(
            color: accepted.isNotEmpty ? Colors.grey[100] : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Excluded Tags",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 15,
                ),
                if (tags.length <= 0)
                  Text(
                    "Drag and drop Tags here",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ...tags
                    .map((tag) => TagFilterItem(
                        onTap: () => Provider.of<SearchController>(context,
                                listen: false)
                            .removeExcludedTag(tag),
                        tagTitle: allTags!
                                .firstWhere((allTag) => allTag.data.id == tag)
                                .data
                                .attributes
                                .name['en'] ??
                            ""))
                    .toList(),
                SizedBox(
                  height: 15,
                ),
                if (tags.length > 0)
                  Text(
                    "Tap to delete",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                if (tags.length > 0)
                  SizedBox(
                    height: 15,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagSelect extends StatelessWidget {
  final List<TagsModel> tags;
  final String label;
  const TagSelect({Key? key, required this.tags, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var include = Provider.of<SearchController>(context).includedTags;
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
                .map((tag) => Draggable<String>(
                      feedback: Material(
                        child: Container(
                          child: TagFilterItem(
                            tagTitle: tag.data.attributes.name['en'] ?? "",
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        color: Colors.grey[100],
                        child: TagFilterItem(
                          tagTitle: tag.data.attributes.name['en'] ?? "",
                        ),
                      ),
                      data: tag.data.id,
                      child: TagFilterItem(
                        tagTitle: tag.data.attributes.name['en'] ?? "",
                      ),
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
    required this.tagTitle,
    this.onTap,
  }) : super(key: key);

  final String tagTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.5))),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(tagTitle,
              textAlign: TextAlign.center,
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
