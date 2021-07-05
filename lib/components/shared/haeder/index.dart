import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final List<Widget> actions;
  final Widget image;

  const Header(this.actions, this.image);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                ...actions
              ],
            ),
          )),
          SizedBox(
            width: 30,
          ),
          image,
        ],
      ),
    );
  }
}
