import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigurationCount extends StatefulWidget {
  const ConfigurationCount({Key? key}) : super(key: key);

  @override
  _ConfigurationCountState createState() => _ConfigurationCountState();
}

class _ConfigurationCountState extends State<ConfigurationCount> {
  static final storage = new FlutterSecureStorage();
  late TextEditingController _defLoadCountcontroller =
      new TextEditingController();
  late TextEditingController _defLoadMorecontroller =
      new TextEditingController();

  static const defCount = 'DEF_LOAD_COUNT';
  static const defLoad = 'DEF_LOAD_MORE_COUNT';

  static const defLoadQuantity = 30;

  @override
  void initState() {
    super.initState();
    setDefValues();
  }

  void setDefValues() async {
    _defLoadCountcontroller.text =
        await storage.read(key: defCount) ?? defLoadQuantity.toString();
    _defLoadMorecontroller.text =
        await storage.read(key: defLoad) ?? defLoadQuantity.toString();
  }

  void changeDefLoadCount(String value) async {
    await storage.write(key: defCount, value: value);
  }

  void changeDefLoadMore(String value) async {
    await storage.write(key: defLoad, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Load Count"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Default Item Load Count",
              style: Theme.of(context).textTheme.headline3,
            ),
            TextField(
                controller: _defLoadCountcontroller,
                onChanged: changeDefLoadCount,
                keyboardType: TextInputType.number),
            SizedBox(
              height: 15,
            ),
            Text(
              "How many items to load initially when looking at item lists. A lower value may reduce the time taken on slower networks.",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Text(
              "Load More Load Count",
              style: Theme.of(context).textTheme.headline3,
            ),
            TextField(
                controller: _defLoadMorecontroller,
                onChanged: changeDefLoadMore,
                keyboardType: TextInputType.number),
            SizedBox(
              height: 15,
            ),
            Text(
              "How many more items to load when a Load More  button is pressed. A lower value may reduce the time taken on slower networks.",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
