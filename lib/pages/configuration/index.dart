import 'package:flutter/material.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import 'choices.dart';
import 'dart:convert';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: languages.map((item) {
            return MultiSelectItem(item['code'], item['label']);
          }).toList(),
          initialValue: [],
          onConfirm: (values) {
            print(values);
          },
          searchable: true,
          // listType: MultiSelectListType.CHIP,
          maxChildSize: 1,
          initialChildSize: 0.8,
          // minChildSize: 0.8,
          title: Text("Language"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // const SizedBox(height: 15),
            // ElevatedButton(
            //     onPressed: () => _showMultiSelect(context), child: Text("Open"))
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  SizedBox(
                    width: 65,
                    height: 65,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                      backgroundColor: Colors.transparent,
                      radius: 15.0,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    Provider.of<LoginController>(context).username ?? "Guest",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () => _showMultiSelect(context),
                  leading: SizedBox(
                    width: 65,
                    child: Align(
                      child: Icon(
                        Icons.language,
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment(0, 0),
                    ),
                  ),
                  title: Text("Language"),
                  contentPadding: EdgeInsets.all(15),
                  visualDensity: VisualDensity.standard,
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15),
                    child: Text(
                        "The default language the filter for chapter list is set to."),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: SizedBox(
                    width: 65,
                    child: Align(
                      child: Icon(
                        Icons.filter_list_alt,
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment(0, 0),
                    ),
                  ),
                  title: Text("Content Filter"),
                  contentPadding: EdgeInsets.all(15),
                  visualDensity: VisualDensity.standard,
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15),
                    child: Text(
                        "Choose how this site displays explicit material."),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: SizedBox(
                    width: 65,
                    child: Align(
                      child: Icon(
                        Icons.format_list_numbered,
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment(0, 0),
                    ),
                  ),
                  title: Text("Default Item Load Count"),
                  contentPadding: EdgeInsets.all(15),
                  visualDensity: VisualDensity.standard,
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15),
                    child: Text(
                        "A lower value may reduce the time taken on slower networks."),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: SizedBox(
                    width: 65,
                    child: Align(
                      child: Icon(
                        Icons.format_list_numbered_rtl,
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment(0, 0),
                    ),
                  ),
                  title: Text("Load More Load Count"),
                  contentPadding: EdgeInsets.all(15),
                  visualDensity: VisualDensity.standard,
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15),
                    child: Text(
                        "How many items to load initially when looking at item lists."),
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
