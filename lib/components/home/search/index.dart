import 'package:flutter/material.dart';
import 'package:mangadex/components/home/search/type/index.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const SearchTab(this._scaffoldKey);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with AutomaticKeepAliveClientMixin<SearchTab> {
  ScrollController _controller = new ScrollController();

  String searchValue = "";
  bool showSearch = true;
  bool showScrollUp = false;

  void onChange(newValue) {
    setState(() {
      searchValue = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(onScroll);
  }

  void onScroll() {
    print(_controller.position.atEdge);
    if (_controller.position.pixels != 0) {
      if (!showScrollUp) {
        setState(() {
          showScrollUp = true;
        });
      }

      return;
    }

    if (showScrollUp) {
      setState(() {
        showScrollUp = false;
      });
    }
  }

  void onSubmitted() {
    setState(() {
      showSearch = false;
    });

    Provider.of<SearchController>(context, listen: false).title = searchValue;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (context, value) => [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            leading: Container(
              width: 0,
            ),
            leadingWidth: 0,
            title: Row(
              children: [
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
            actions: [Container()],
          )
        ],
        body: showSearch
            ? SearchType(
                searchValue: searchValue,
              )
            : Expanded(
                child: SearchPage(
                    controller: _controller, showScrollUp: showScrollUp),
              ),
      ),
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
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 15),
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
            size: 20,
          ),
          filled: true,
          fillColor: Theme.of(context).accentColor,
          hintText: 'Manga name, author or scan',
          contentPadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.4))),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
