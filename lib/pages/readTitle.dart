import 'package:flutter/material.dart';

class ReadTitle extends StatelessWidget {
  double sensitivity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: [
                  InteractiveViewer(
                    child: Image.asset("/manga/1.jpg"),
                  ),
                  InteractiveViewer(child: Image.asset("/manga/2.jpg")),
                  InteractiveViewer(child: Image.asset("/manga/3.jpg")),
                  InteractiveViewer(child: Image.asset("/manga/4.jpg")),
                  // Container(
                  //   color: Colors.blue,
                  //   child: Image.asset("/manga/2.jpg"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
