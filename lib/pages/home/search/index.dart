import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String searchValue = "";
  void onChange(newValue) {
    setState(() {
      searchValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SearchInput(onChange),
        SizedBox(
          height: 30,
        ),
        if (searchValue.isNotEmpty)
          Text(
            "Are you searching for",
            style: Theme.of(context).textTheme.headline3,
          ),
        if (searchValue.isNotEmpty)
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                trailing: Icon(Icons.navigate_next),
                subtitle: Text("Manga Name"),
                title: Text(
                  searchValue,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
        if (searchValue.isNotEmpty)
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(Icons.navigate_next),
            subtitle: Text("Author Name"),
            title: Text(
              searchValue,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        if (searchValue.isNotEmpty)
          ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(Icons.navigate_next),
            subtitle: Text("Scan group name"),
            title: Text(
              searchValue,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
      ]),
    );
  }
}

class SearchInput extends StatefulWidget {
  final Function onChange;
  SearchInput(this.onChange);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _textController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _textController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    widget.onChange(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).accentColor,
        hintText: 'Manga name, author or scan',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
