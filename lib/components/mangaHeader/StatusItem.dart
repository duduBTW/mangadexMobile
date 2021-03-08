import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  final String label;
  final String value;

  const StatusItem({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2)),
          width: double.infinity,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
