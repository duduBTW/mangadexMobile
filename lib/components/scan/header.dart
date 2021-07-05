import 'package:flutter/material.dart';
import 'package:mangadex/service/scan/model/index.dart';

class HeaderScan extends StatelessWidget {
  final ScanlationGroupDataModel scan;

  const HeaderScan(this.scan);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.primaryColor,
              size: 24,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  scan.attributes.name,
                  style: theme.textTheme.headline1,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                color: Colors.red,
                width: 60,
                height: 60,
              )
            ],
          ),
        )
      ],
    );
  }
}
