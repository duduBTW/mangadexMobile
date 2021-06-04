import 'package:flutter/material.dart';

class ButtonAction extends StatefulWidget {
  final IconData icon;
  const ButtonAction(this.icon);

  @override
  _ButtonActionState createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            active = !active;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              gradient: active
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE866A7), Color(0xffFF7D7D)],
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.5))),
          width: 60,
          height: 60,
          child: Icon(
            widget.icon,
            color: active ? Colors.white : Theme.of(context).primaryColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
