import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/components/shared/title/index.dart';
import 'package:mangadex/pages/home/search/index.dart';
import 'package:mangadex/pages/login/index.dart';
import 'package:mangadex/utils/login/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _logged = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void redirectMangaAll(BuildContext ctx) {
    Navigator.of(ctx).pushNamed("/manga/list");
  }

  @override
  void initState() {
    super.initState();

    // Checks if the user is logged in
    getLogin();
  }

  void getLogin() async {
    if (await LoginController.getToken() != null) onLoginSuccess();
  }

  void onLoginSuccess() {
    setState(() {
      _logged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Column(
        children: [
          Hero(
            tag: "manga-list",
            child: Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.25),
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
                      color: Theme.of(context).primaryColor.withOpacity(0.25),
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
      ),
      SearchTab(),
      _logged
          ? Column(
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
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.25),
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
              ],
            )
          : LoginPage(
              onLoginSuccess: onLoginSuccess,
            )
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                    backgroundColor: Colors.transparent,
                    radius: 15.0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "DuduBTW",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Member",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  label: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  label: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  label: Text(
                    "Log Out",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Spacer(),
                Icon(
                  Icons.feedback,
                  color: Theme.of(context).primaryColor,
                  size: 18,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Feedback",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Image.network(
            "https://i.pinimg.com/originals/50/77/04/50770411adf0bd85919b46a54b6be20d.jpg"),
      ),
      backgroundColor: _selectedIndex == 0
          ? Theme.of(context).accentColor
          : Theme.of(context).backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            actions: [Container()],
            automaticallyImplyLeading: false,
            // Provide a standard title.
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                    backgroundColor: Colors.transparent,
                    radius: 15.0,
                  ),
                ),
              ],
            ),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            elevation: 0,
            backgroundColor: _selectedIndex == 0
                ? Theme.of(context).accentColor
                : Theme.of(context).backgroundColor,
            // Display a placeholder widget to visualize the shrinking size.
            // Make the initial height of the SliverAppBar larger than normal.
            // expandedHeight: 50,
          ),
          SliverToBoxAdapter(
            child: pages[_selectedIndex],
          )
        ],
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
