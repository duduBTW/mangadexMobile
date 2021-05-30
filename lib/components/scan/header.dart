import 'package:flutter/material.dart';

class HeaderScan extends StatelessWidget {
  final String name;

  const HeaderScan(this.name);

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
            onPressed: () {},
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
                  name,
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
