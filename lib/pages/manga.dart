import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MangaPage extends StatelessWidget {
  void _open(BuildContext context) {
    showBarModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) => Container(
              child: Text("aa"),
              height: 200,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("teste"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () => _open(context),
          child: Text("Open Modal"),
        ),
      ),
    );
  }
}
