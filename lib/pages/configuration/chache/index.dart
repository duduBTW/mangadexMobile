import 'package:flutter/material.dart';

class CacheConfiguration extends StatefulWidget {
  const CacheConfiguration({Key? key}) : super(key: key);

  @override
  _CacheConfigurationState createState() => _CacheConfigurationState();
}

class _CacheConfigurationState extends State<CacheConfiguration> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  void showCacheDuration() {
    print("a");
    scaffoldState.currentState!.showBottomSheet(
        (context) => Container(
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
                    title: const Text('1 day'),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                  ListTile(
                    title: const Text('1 week'),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                  ListTile(
                    title: const Text('1 month'),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                  ListTile(
                    title: const Text('1 year'),
                    leading: Radio(
                      onChanged: (_) {},
                      value: "",
                      groupValue: [],
                    ),
                  ),
                ],
              ),
            ),
        backgroundColor: Colors.transparent);
  }

  void clearCache() {
    final snackBar = SnackBar(content: Text('Cache cleared with success!'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Cache"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text("Clear Cache"),
            leading: SizedBox(
              width: 65,
              child: Align(
                child: Icon(
                  Icons.clear_all,
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment(0, 0),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  Text("Clear all image caches (manga pages, miniatures etc)"),
            ),
            onTap: clearCache,
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text("Set cache duration"),
            leading: SizedBox(
              width: 65,
              child: Align(
                child: Icon(
                  Icons.timelapse_sharp,
                  color: Theme.of(context).primaryColor,
                ),
                alignment: Alignment(0, 0),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("How long the cache  will stay on your device"),
            ),
            onTap: showCacheDuration,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Max cache quantity",
                  style: Theme.of(context).textTheme.headline3,
                ),
                TextField(
                    // controller: _defLoadMorecontroller,
                    // onChanged: changeDefLoadMore,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Maximum number of manga pages cached, if the maximum number is reached the newer image will replace the older one. A lower number will consume less storage space",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Max cache image quality (pixels)",
                  style: Theme.of(context).textTheme.headline3,
                ),
                TextField(
                    // controller: _defLoadMorecontroller,
                    // onChanged: changeDefLoadMore,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Maximum resolution of manga pages cached. A lower number will consume less storage space",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
