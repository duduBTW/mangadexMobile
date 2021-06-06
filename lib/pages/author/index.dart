import 'package:flutter/material.dart';
import 'package:mangadex/components/author/mangas.dart';
import 'package:mangadex/components/shared/actions/button.dart';
import 'package:mangadex/components/shared/background/index.dart';
import 'package:mangadex/components/shared/haeder/index.dart';
import 'package:mangadex/components/shared/info/index.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Header(
              [ButtonAction(Icons.favorite_border_rounded)],
              Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 16,
                        offset: Offset(4, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: Alignment(0, -1),
                        image: NetworkImage(
                            "https://pbs.twimg.com/media/E0nea50VgAAB2d_?format=jpg&name=medium"))),
              ),
            ),
            Info([
              Text(
                "A salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "A salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.\nA salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ], "Author name"),
            MangasAuthor()
          ],
        ),
        "https://pbs.twimg.com/media/E0nea50VgAAB2d_?format=jpg&name=medium");
  }
}
