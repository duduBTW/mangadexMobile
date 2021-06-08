import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool loading;
  final Function? onClick;
  const Button(this.onClick, this.loading);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick != null && !loading ? onClick!() : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
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
        child: !loading
            ? Text(
                "Send",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, letterSpacing: 1),
              )
            : SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
      ),
    );
  }
}
