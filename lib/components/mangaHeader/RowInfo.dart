import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  const RowInfo({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }
}
