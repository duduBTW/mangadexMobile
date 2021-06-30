import 'package:flutter/material.dart';
import 'package:mangadex/components/home/follows/feed.dart';
import 'package:mangadex/components/home/landing/index.dart';
import 'package:mangadex/components/home/search/index.dart';
import 'package:mangadex/components/shared/SideBar/index.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/components/shared/title/index.dart';
import 'package:mangadex/pages/login/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final MangadexService http;
  const HomePage(this.http);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.jumpToPage(index);
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
    if (await LoginControllerHelper.getToken() != null) onLoginSuccess();
  }

  void onLoginSuccess() {}

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Landing(),
      // SearchTab(_scaffoldKey),
      Provider.of<LoginController>(context).loggedIn
          ? Follows(
              scaffoldKey: _scaffoldKey,
            )
          : LoginPage(
              onLoginSuccess: onLoginSuccess,
            )
    ];

    return ChangeNotifierProvider<MangaController>(
      create: (_) => MangaController(widget.http),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: SideBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        // body: pages[_selectedIndex],
        body: PageView(
          controller: _pageController,
          children: pages,
          onPageChanged: _onItemTapped,
          physics: NeverScrollableScrollPhysics(),
          // child: _childern[_currentIndex],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.search,
                //   ),
                //   label: 'Search',
                // ),
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
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ],
        ),
      ),
    );
  }
}
