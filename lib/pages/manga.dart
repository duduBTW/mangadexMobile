import 'package:flutter/material.dart';
import 'package:mangadex/components/mangaBody/index.dart';
import 'package:mangadex/components/mangaHeader/index.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MangaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Senpai ga Uzai Kouhai no Hanashi",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MangaHeader(),
            SizedBox(
              height: 40,
            ),
            Expanded(child: MangaBody())
            // ElevatedButton(
            //   onPressed: () => _open(context),
            //   child: Text("Open Modal"),
            // ),
          ],
        ),
      ),
    );
  }
}
