import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabItem extends StatelessWidget {
  final String _tabText;
  final int _selectedPage;
  final int _index;

  const TabItem(this._tabText, this._selectedPage, this._index);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            _tabText,
            style: GoogleFonts.rubik(
              textStyle: Theme.of(context).textTheme.headline2,
              color:
                  _selectedPage == _index ? Colors.white : Color(0xfff949494),
              fontSize: 16,
              fontWeight:
                  _selectedPage == _index ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (_selectedPage == _index)
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
