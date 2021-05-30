import 'package:flutter/material.dart';
import 'package:mangadex/components/scan/header.dart';
import 'package:mangadex/components/scan/members/index.dart';

class ScanPage extends StatelessWidget {
  final String name = "Black Stray Cat Scans";
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
              children: [HeaderScan(name), MembersScan()],
            ),
          ),
        ),
      ),
    );
  }
}
