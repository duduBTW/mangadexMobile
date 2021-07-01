import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/pages/configuration/reader/index.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import 'package:page_transition/page_transition.dart';

import 'chache/index.dart';
import 'choices.dart';
import 'count/index.dart';
import 'dart:convert';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  static final storage = new FlutterSecureStorage();
  static const LANGUAGE = 'DEF_LANGUAGE';
  static const CONTENT_FILTERS = 'DEF_CONTENT_FILTERS';

  List<dynamic>? defLanguage;
  List<dynamic>? defContentFilter;

  void changeDefLanguage(String value) async {
    await storage.write(key: LANGUAGE, value: value);
  }

  void changeDefContentFilter(String value) async {
    await storage.write(key: CONTENT_FILTERS, value: value);
  }

  void _showMultiSelect(BuildContext context) async {
    var def = await storage.read(key: LANGUAGE);
    if (def != null)
      setState(() {
        defLanguage = json.decode(def);
      });

    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: languages.map((item) {
            return MultiSelectItem(item['code'], item['label']);
          }).toList(),
          initialValue: defLanguage,
          onConfirm: (values) {
            changeDefLanguage(json.encode(values));
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

  void _showConfigurationFilters(BuildContext context) async {
    final List<Map<String, String>> tags = [
      {"code": "safe", "label": "Safe content"},
      {"code": "suggestive", "label": "Suggestive content"},
      {"code": "erotica", "label": "Erotica content"},
      {"code": "pornographic", "label": "Pornographic content"},
    ];
    var def = await storage.read(key: CONTENT_FILTERS);
    if (def != null)
      setState(() {
        defContentFilter = json.decode(def);
      });

    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: tags.map((item) {
            return MultiSelectItem(item['code'], item['label']!);
          }).toList(),
          initialValue: defContentFilter,
          onConfirm: (values) {
            changeDefContentFilter(json.encode(values));
          },
          searchable: true,
          // listType: MultiSelectListType.CHIP,
          maxChildSize: 1,
          initialChildSize: 0.8,
          // minChildSize: 0.8,
          title: Text("Content Filter"),
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
        child: SingleChildScrollView(
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
                physics: NeverScrollableScrollPhysics(),
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
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: MangaReaderConfiguration())),
                    leading: SizedBox(
                      width: 65,
                      child: Align(
                        child: Icon(
                          Icons.chrome_reader_mode_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment(0, 0),
                      ),
                    ),
                    title: Text("Manga reader"),
                    contentPadding: EdgeInsets.all(15),
                    visualDensity: VisualDensity.standard,
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 15),
                      child: Text("Change the manga reader configuration."),
                    ),
                  ),
                  ListTile(
                    onTap: () => _showConfigurationFilters(context),
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
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ConfigurationCount())),
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
                    title: Text("Load Count"),
                    contentPadding: EdgeInsets.all(15),
                    visualDensity: VisualDensity.standard,
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 15),
                      child: Text("Set load counts."),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: CacheConfiguration())),
                    leading: SizedBox(
                      width: 65,
                      child: Align(
                        child: Icon(
                          Icons.cached_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment(0, 0),
                      ),
                    ),
                    title: Text("Cache"),
                    contentPadding: EdgeInsets.all(15),
                    visualDensity: VisualDensity.standard,
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 15),
                      child: Text("..."),
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
      ),
    );
  }
}
