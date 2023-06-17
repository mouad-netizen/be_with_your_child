import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpcities/child/childLocation.dart';
import 'package:tpcities/database/db.dart';
import 'package:tpcities/new_pages/location_file.dart';

import '../new_pages/childimages.dart';
import '../new_pages/daily_screen.dart';
import 'childmassage.dart';
import 'childpic.dart';
import 'dailychild.dart';
import 'package:badges/badges.dart' as badges;





class ChildHome extends StatefulWidget {
  const ChildHome({Key? key}) : super(key: key);

  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  int pageIndex = 0;
  int notificationCount = 0;

  List<Widget> pages = [
    DailyChild(),
    ChildLocation(),
    ChildPic(),
    ChatScreen(),
    ChatScreen(),
  ];

  @override
  void initState() {
    super.initState();
    notificationCount = SqlDb.parentMessages;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.location_solid,
      CupertinoIcons.camera,
      Icons.message,
    ];

    return SqlDb.parentMessages==0?AnimatedBottomNavigationBar(
      icons: iconItems,
      gapLocation: GapLocation.none,
      activeIndex: pageIndex,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      rightCornerRadius: 10,
      iconSize: 25,
      elevation: 2,
      onTap: (index) {
        setTabs(index);
      },
    ):
      badges.Badge(
      position: badges.BadgePosition.topEnd(top: 4, end: 22),
      badgeContent: Text(
        notificationCount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: AnimatedBottomNavigationBar(
        icons: iconItems,
        gapLocation: GapLocation.none,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        iconSize: 25,
        elevation: 2,
        onTap: (index) {
          setTabs(index);
        },
      ),
    );
  }

  void setTabs(int index) {
    setState(() {
      pageIndex = index;
      print('the index is  =====================>$index');
    });
  }
}
