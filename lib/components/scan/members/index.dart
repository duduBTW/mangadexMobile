import 'package:flutter/material.dart';
import 'package:mangadex/service/scan/model/index.dart';

import 'item.dart';

class MembersScan extends StatelessWidget {
  final ScanlationGroupDataModel scan;

  const MembersScan({Key? key, required this.scan}) : super(key: key);

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
          MemberScan(scan.attributes.leader['attributes']['username'],
              "https://i.ytimg.com/vi/g_xWmKCYZ-w/maxresdefault.jpg", true),
          SizedBox(
            height: 30,
          ),
          if (scan.attributes.members != null)
            Text(
              "Members",
              style: Theme.of(context).textTheme.headline3,
            ),
          SizedBox(
            height: 30,
          ),
          if (scan.attributes.members != null)
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) => MemberScan(
                    scan.attributes.members[i]['attributes']['username'],
                    "https://i.ytimg.com/vi/g_xWmKCYZ-w/maxresdefault.jpg"),
                separatorBuilder: (ctx, i) => SizedBox(
                      height: 30,
                    ),
                itemCount: scan.attributes.members.length),
          SizedBox(
            height: 30,
          ),
          // SeeAllMemberScan()
        ],
      ),
    );
  }
}
