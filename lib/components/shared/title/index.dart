import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String titleName;

  const TitleHeader(this.titleName);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleName,
            style: Theme.of(context).textTheme.headline1,
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
