import 'package:flutter/material.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);
  final MangadexService http = new MangadexService();

  void logOut(BuildContext ctx) async {
    Navigator.of(ctx).pop();
    // await LoginController.removeToken();

    Provider.of<LoginController>(ctx, listen: false).logOut().then((_) {
      final snackBar = SnackBar(content: Text('Logged out!'));

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                Provider.of<LoginController>(context).username ?? "Guest",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Member",
                style: Theme.of(context).textTheme.caption,
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
                onPressed: () =>
                    Navigator.of(context).pushNamed("/configuration"),
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
                onPressed: () => logOut(context),
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
    );
  }
}
