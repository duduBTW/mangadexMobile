import 'package:flutter/material.dart';
import 'package:mangadex/components/comments/addComment.dart';
import 'package:mangadex/components/comments/tile.dart';

class CommentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Comments"),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: TileComment(
              comment:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
              name: "Teste",
              imageLink:
                  "https://i1.wp.com/peachsalmanac.com/wp-content/uploads/2017/08/hifumi-new-game-social-anxiety.jpg?resize=620%2C356&ssl=1",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: TileComment(
              comment: "Lorem ipsum dolor sit amet",
              name: "Ababa",
              imageLink:
                  "https://i2.wp.com/peachsalmanac.com/wp-content/uploads/2017/08/Hifumi-new-game.jpg?resize=620%2C496&ssl=1",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Spacer(
            flex: 1,
          ),
          AddComment()
        ],
      ),
    );
  }
}
