import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

class MangaReaderConfiguration extends StatefulWidget {
  const MangaReaderConfiguration({Key? key}) : super(key: key);
  static final List<String> options = ["Standard", "Swipe", "Long Strip"];

  @override
  _MangaReaderConfigurationState createState() =>
      _MangaReaderConfigurationState();
}

class _MangaReaderConfigurationState extends State<MangaReaderConfiguration> {
  static final storage = new FlutterSecureStorage();

  // static final List<String> options = ["Standard", "Swipe", "Long Strip"];

  List<String> options = MangaReaderConfiguration.options;
  List<Widget> optionsContent = [
    StandardMangaConfigs(),
    Column(
      children: [Text("b")],
    ),
    Column(
      children: [Text("c")],
    ),
  ];

  // String selected = "Standard";

  @override
  void initState() {
    super.initState();
    Provider.of<MangaItemController>(context, listen: false).getDefData();
  }

  void setSelected(String newValue) {
    Provider.of<MangaItemController>(context, listen: false).selected =
        newValue;

    storage.write(key: 'DEF_READ_TYPE', value: newValue);
  }

  @override
  Widget build(BuildContext context) {
    var selected = Provider.of<MangaItemController>(context).selected;
    if (selected == null)
      return Center(
        child: CircularProgressIndicator(),
      );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Manga reader"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                ...options
                    .map(
                      (option) => Expanded(
                        child: SelectReaderTypeCard(
                          label: option,
                          selected: selected == option,
                          onTap: () => setSelected(option),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            optionsContent[options.indexOf(selected)]
          ],
        ),
      ),
    );
  }
}

class StandardMangaConfigs extends StatefulWidget {
  const StandardMangaConfigs({
    Key? key,
  }) : super(key: key);

  @override
  _StandardMangaConfigsState createState() => _StandardMangaConfigsState();
}

class _StandardMangaConfigsState extends State<StandardMangaConfigs> {
  bool zoom = true;

  void setZoom(bool newValue) {
    setState(() {
      zoom = newValue;
    });
  }

  void showDirectionModal() {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              margin: EdgeInsets.all(30),
              // height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(30)),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Left To Right'),
                    trailing: Icon(Icons.arrow_forward_rounded),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                  ListTile(
                    title: const Text('Right To Left'),
                    trailing: Icon(Icons.arrow_back_rounded),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                ],
              ),
            ));
  }

  void showFitModal() {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              margin: EdgeInsets.all(30),
              // height: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(30)),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Width'),
                    trailing: Icon(Icons.horizontal_rule_rounded),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                  ListTile(
                    title: const Text('Height'),
                    trailing: Icon(Icons.height),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text("Zoom"),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Enable zoom in and zoom out in a page  while reading"),
          ),
          trailing: Switch(
            value: zoom,
            onChanged: setZoom,
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          title: Text("Direction"),
          onTap: showDirectionModal,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Page change direaction"),
          ),
        ),
        ListTile(
          title: Text("Fit"),
          onTap: showFitModal,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Page fit"),
          ),
        ),
      ],
    );
  }
}

class SelectReaderTypeCard extends StatelessWidget {
  final String label;
  final bool selected;
  final Function()? onTap;
  const SelectReaderTypeCard(
      {Key? key, required this.label, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: selected
                  ? Border.all(color: Theme.of(context).primaryColor)
                  : null),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          alignment: Alignment(0, 0),
          height: 90,
        ),
      ),
    );
  }
}
