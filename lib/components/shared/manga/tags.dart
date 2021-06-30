import 'package:flutter/material.dart';
import 'package:mangadex/service/manga/model/index.dart';

class MangaTags extends StatelessWidget {
  const MangaTags({
    Key? key,
    required this.manga,
  }) : super(key: key);

  final MangaModel manga;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: manga.data.attributes.tags.length,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return TagItem(
          label: manga.data.attributes.tags[index]['attributes']['name']['en'],
        );
      },
      separatorBuilder: (ctx, index) => SizedBox(
        width: 5,
      ),
    );
  }
}

class MangaTagsGrid extends StatelessWidget {
  const MangaTagsGrid({
    Key? key,
    required this.manga,
  }) : super(key: key);

  final MangaModel manga;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 15 / 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15),
      shrinkWrap: true,
      itemCount: manga.data.attributes.tags.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return TagItem(
          label: manga.data.attributes.tags[index]['attributes']['name']['en'],
        );
      },
    );
  }
}

class TagItem extends StatelessWidget {
  const TagItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, 0),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        child: Text(label,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                fontSize: 12)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.5))));
  }
}
