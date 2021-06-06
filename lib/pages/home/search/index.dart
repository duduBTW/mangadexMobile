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
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        // padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SearchInput(onChange),
          if (searchValue.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Are you searching for",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            searchValue,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("•", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Manga Name",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/search");
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              searchValue,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("•", style: TextStyle(color: Colors.grey)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Author Name",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ],
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            searchValue,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("•", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Scan group name",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ],
                    )),
              ],
            )
          else
            Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.plagiarism_outlined,
                                size: 32,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Advanced Manga Search",
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_search_sharp,
                                size: 32,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Advanced Author Search",
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(30), // if you need this
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.group_sharp,
                                size: 32,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Advanced Scan Search",
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
        ]),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(30),
      child: TextField(
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
      ),
    );
  }
}
