import 'package:flutter/material.dart';
import 'package:mangadex/components/scan/header.dart';
import 'package:mangadex/components/scan/members/index.dart';
import 'package:mangadex/service/scan/model/index.dart';

class ScanPage extends StatelessWidget {
  static String routeName = "/scan/group";
  // final String name = "Black Stray Cat Scans";

  final ScanlationGroupDataModel scan;

  const ScanPage({Key? key, required this.scan}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.accentColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderScan(scan),
                MembersScan(
                  scan: scan,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
