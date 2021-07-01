import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/components/shared/chapters/index.dart';
import 'package:mangadex/pages/configuration/reader/index.dart';
import 'package:mangadex/pages/reader/standard/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

import 'longStrip/index.dart';

class MangaReaderPage extends StatefulWidget {
  static const routeName = '/manga/item/chapter';

  final ChapterModel chapter;
  const MangaReaderPage({Key? key, required this.chapter}) : super(key: key);

  @override
  _MangaReaderPageState createState() => _MangaReaderPageState();
}

class _MangaReaderPageState extends State<MangaReaderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MangaItemController>(context, listen: false)
        .updateServer(widget.chapter.data.id);
  }

  @override
  Widget build(BuildContext context) {
    var server = Provider.of<MangaItemController>(context).serverUrl;
    return server != null
        ? MangaReader(
            chapter: widget.chapter,
          )
        : Scaffold(
            body: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class MangaReader extends StatefulWidget {
  final ChapterModel chapter;
  const MangaReader({Key? key, required this.chapter}) : super(key: key);

  @override
  _MangaReaderState createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader> {
  static final storage = new FlutterSecureStorage();

  List<String> options = MangaReaderConfiguration.options;
  String? selected;
  @override
  void initState() {
    super.initState();
    getDefData();
  }

  void getDefData() async {
    var newValue = await storage.read(key: 'DEF_READ_TYPE');

    if (newValue != null) {
      setState(() {
        selected = newValue;
      });

      return;
    }

    setState(() {
      selected = "Standard";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selected == null) return Container();

    List<Widget> readers = [
      StandardMangaReader(
        chapter: widget.chapter,
      ),
      Container(child: Text("Working on it -.-")),
      LongStripReader(
        chapter: widget.chapter,
      )
    ];

    return GestureDetector(
      // onDoubleTap: onTapScreen,
      child: Scaffold(
        body: SafeArea(
          child: readers[options.indexOf(selected!)],
        ),
      ),
    );
  }
}

class ChapFinished extends StatelessWidget {
  const ChapFinished({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var next = Provider.of<MangaItemController>(context).next;
    var before = Provider.of<MangaItemController>(context).before;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text("Next chapter"),
            ),
            (next != "")
                ? ChapManga(
                    label: next,
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 30, left: 30),
                    child: Row(
                      children: [
                        Text("Next chapter not avaliable"),
                        SizedBox(
                          width: 15,
                        ),
                        Image.network(
                            "https://cdn.betterttv.net/frankerfacez_emote/378987/2"),
                      ],
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text("Previus chapter"),
            ),
            ChapManga(
              label: before,
            ),
          ],
        ),
      ),
    );
  }
}
