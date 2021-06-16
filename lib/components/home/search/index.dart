import 'package:flutter/material.dart';
import 'package:mangadex/components/home/search/type/index.dart';
import 'package:mangadex/pages/search/index.dart';

class SearchTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const SearchTab(this._scaffoldKey);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with AutomaticKeepAliveClientMixin<SearchTab> {
  String searchValue = "";
  bool showSearch = true;
  void onChange(newValue) {
    setState(() {
      searchValue = newValue;
    });
  }

  void onSubmitted() {
    setState(() {
      showSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () => widget._scaffoldKey.currentState?.openDrawer(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                backgroundColor: Colors.transparent,
                radius: 15.0,
              ),
            ),
            Expanded(child: SearchInput(onChange, onSubmitted)),
          ],
        ),
        showSearch
            ? SearchType(
                searchValue: searchValue,
              )
            : Expanded(
                child: SearchPage(),
              ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchInput extends StatefulWidget {
  final Function onChange;
  final Function onSubmitted;
  SearchInput(this.onChange, this.onSubmitted);

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
    return Padding(
      padding: const EdgeInsets.all(30),
      child: TextField(
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          widget.onSubmitted();
        },
        autofocus: true,
        cursorColor: Colors.black,
        controller: _textController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          filled: true,
          fillColor: Theme.of(context).accentColor,
          hintText: 'Manga name, author or scan',
          contentPadding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4))),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
