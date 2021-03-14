import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileComment extends StatelessWidget {
  final String name;
  final String comment;
  final String imageLink;

  const TileComment({Key key, this.name, this.comment, this.imageLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipOval(
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.roboto(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    comment,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
