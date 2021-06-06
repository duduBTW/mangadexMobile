import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function? onClick;
  const Button({Key? key, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick != null ? onClick!() : null,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffE866A7), Color(0xffFF7D7D)],
            )),
        child: Text(
          "Send",
          style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1),
        ),
      ),
    );
  }
}
