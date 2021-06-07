import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/components/shared/title/index.dart';
import 'package:mangadex/pages/home/search/index.dart';
import 'package:mangadex/pages/login/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void redirectMangaAll(BuildContext ctx) {
    Navigator.of(ctx).pushNamed("/manga/list");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: "manga-list",
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Latest Updated",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            "See all",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onPressed: () => redirectMangaAll(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: "a-list",
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recently Added",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      MangaMainItem(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Text(
                            "See all",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onPressed: () => redirectMangaAll(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          )),
      SearchTab(),
      Container(
        child: LoginPage(),
      )
    ];

    return Scaffold(
      backgroundColor: _selectedIndex == 0
          ? Theme.of(context).accentColor
          : Theme.of(context).backgroundColor,
      body: SafeArea(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chrome_reader_mode_outlined,
            ),
            label: 'Follows',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: _selectedIndex == 0
            ? Theme.of(context).accentColor
            : Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
