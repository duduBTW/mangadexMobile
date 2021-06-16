import 'package:flutter/material.dart';

class SearchType extends StatelessWidget {
  final String searchValue;
  const SearchType({Key? key, required this.searchValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchValue.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Are you searching for",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          searchValue,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("•", style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Manga Name",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ],
                  )),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/search");
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            searchValue,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("•", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Author Name",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        ),
                      ],
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          searchValue,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("•", style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Scan group name",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
            ],
          )
        : Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(30), // if you need this
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Icon(
                              Icons.plagiarism_outlined,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Advanced Manga Search",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          );
  }
}
