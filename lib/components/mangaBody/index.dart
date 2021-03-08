import 'package:flutter/material.dart';
import 'package:mangadex/components/mangaHeader/RowInfo.dart';
import 'package:mangadex/components/tabs/index.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MangaBody extends StatelessWidget {
  final List<String> _tabs = const ["Chapters", "Comments"];
  final int _selectedPage = 0;

  void _open(BuildContext context) {
    showBarModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) => Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Text(
                      "Ch. 141",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RowInfo(
                      label: "Grup",
                      value: "Ultralight Scans | CClaw Translation",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RowInfo(
                      label: "User",
                      value: "Checkmate_Tan",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RowInfo(
                      label: "Views",
                      value: "13,219",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RowInfo(
                      label: "Published at",
                      value: "1 mo ago",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RowInfo(
                      label: "Comments",
                      value: "6",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: Container(
                          alignment: Alignment(0, 0),
                          height: 35,
                          width: double.infinity,
                          child: Text("Go to chapter"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      alignment: Alignment(0, 0),
                      height: 35,
                      width: double.infinity,
                      child: Text("See comments"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              height: 430,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabsManga(
          tabs: _tabs,
          selectedPage: _selectedPage,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                return Container(
                  child: ListTile(
                    onLongPress: () => _open(context),
                    title: Text(
                      "sa",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      "acascas",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(
                    height: 5,
                  ),
              itemCount: 30),
        ),
      ],
    );
  }
}
