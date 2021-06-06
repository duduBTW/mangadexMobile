import 'package:flutter/material.dart';

final kInnerDecoration = BoxDecoration(
  color: Color(0xffFFFEFE),
  border: Border.all(color: Color(0xffFFFEFE)),
  borderRadius: BorderRadius.circular(10),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Color(0xffE866A7), Color(0xffFF7D7D)]),
  border: Border.all(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(11),
);

class MemberScan extends StatelessWidget {
  final String name;
  final String image;
  final bool leader;

  MemberScan(this.name, this.image, [this.leader = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(leader ? 1.0 : 2.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: kInnerDecoration,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image))),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Text(
                name,
                style: Theme.of(context).textTheme.headline4,
              )),
              Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
      // height: 70,
      width: double.infinity,
      decoration: leader ? kGradientBoxDecoration : BoxDecoration(),
    );
  }
}

class SeeAllMemberScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: kInnerDecoration,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment(0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                  child: Text(
                "See All...",
                style: Theme.of(context).textTheme.headline4,
              )),
              Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
      // height: 70,
      width: double.infinity,
      decoration: BoxDecoration(),
    );
  }
}
