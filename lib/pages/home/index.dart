import 'package:flutter/material.dart';
import 'package:mangadex/components/home/follows/index.dart';
import 'package:mangadex/components/home/landing/index.dart';
import 'package:mangadex/components/home/search/index.dart';
import 'package:mangadex/components/shared/SideBar/index.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/components/shared/title/index.dart';
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
      Landing(),
      SearchTab(),
      _logged
          ? Follows()
          : LoginPage(
              onLoginSuccess: onLoginSuccess,
            )
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      endDrawer: Drawer(
        child: Image.network(
            "https://i.pinimg.com/originals/50/77/04/50770411adf0bd85919b46a54b6be20d.jpg"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: pages[_selectedIndex],
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
            label: 'My mangas',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
