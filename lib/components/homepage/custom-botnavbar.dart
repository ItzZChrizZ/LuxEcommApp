// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class GetBottomNavBar extends StatefulWidget {
  final int selectedTab;
  final Function(int)? tabPressed;
  const GetBottomNavBar({Key? key, required this.selectedTab, this.tabPressed})
      : super(key: key);

  @override
  State<GetBottomNavBar> createState() => _GetBottomNavBarState();
}

class _GetBottomNavBarState extends State<GetBottomNavBar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                spreadRadius: 1.0,
                blurRadius: 30.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBtn(
              selected: _selectedTab == 0 ? true : false,
              imagePath: 'assets/icons/home.png',
              onPressed: () {
                widget.tabPressed!(0);
              },
            ),
            BottomTabBtn(
              selected: _selectedTab == 1 ? true : false,
              imagePath: 'assets/icons/search-interface-symbol.png',
              onPressed: () {
                widget.tabPressed!(1);
              },
            ),
            BottomTabBtn(
              selected: _selectedTab == 2 ? true : false,
              imagePath: 'assets/icons/ribbon.png',
              onPressed: () {
                widget.tabPressed!(2);
              },
            ),
            BottomTabBtn(
              selected: _selectedTab == 3 ? true : false,
              imagePath: 'assets/icons/user.png',
              onPressed: () {
                widget.tabPressed!(3);
              },
            ),
          ],
        ));
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool? selected;

  final onPressed;
  const BottomTabBtn(
      {Key? key, required this.imagePath, this.selected, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 2,
          color: _selected
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
        ))),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 10.0,
        ),
        child: Image(
          height: 26,
          width: 26,
          color: _selected
              ? Theme.of(context).colorScheme.secondary
              : Colors.black,
          image: AssetImage(
            imagePath,
          ),
        ),
      ),
    );
  }
}
