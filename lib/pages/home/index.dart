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
    if (await LoginController.getToken() != null) onLoginSuccess();
  }

  void onLoginSuccess() {}

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Landing(_scaffoldKey),
      SearchTab(_scaffoldKey),
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
        endDrawer: Drawer(
          child: Image.network(
              "https://i.pinimg.com/originals/50/77/04/50770411adf0bd85919b46a54b6be20d.jpg"),
        ),
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
            // Container(
            //   margin: EdgeInsets.only(bottom: 5, left: 30, right: 30, top: 5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30),
            //     color: Theme.of(context).accentColor,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(30),
            //             child: Image.network(
            //               "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg",
            //               height: 60,
            //             ),
            //           ),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Manga name",
            //                 style: Theme.of(context).textTheme.headline3,
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               Text(
            //                 "Chap 12",
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(
            //             Icons.close,
            //             size: 18,
            //             color: Colors.red,
            //           ),
            //           SizedBox(
            //             width: 15,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            BottomNavigationBar(
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
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ],
        ),
      ),
    );
  }
}
