import 'package:flutter/material.dart';

import 'item.dart';

class MembersScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Leader",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 30,
          ),
          MemberScan("Chronolla",
              "https://i.ytimg.com/vi/g_xWmKCYZ-w/maxresdefault.jpg", true),
          SizedBox(
            height: 30,
          ),
          Text(
            "Members",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 30,
          ),
          MemberScan("Chronolla",
              "https://i.ytimg.com/vi/g_xWmKCYZ-w/maxresdefault.jpg"),
          SizedBox(
            height: 30,
          ),
          MemberScan("DuduBTW",
              "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
          SizedBox(
            height: 30,
          ),
          SeeAllMemberScan()
        ],
      ),
    );
  }
}
