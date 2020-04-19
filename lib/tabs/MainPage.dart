import 'package:flutter/material.dart';
import 'package:flutterapp/tabs/ProfilePage.dart';
import 'package:flutterapp/tabs/ToDoListPage.dart';

import 'HomePage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<MainPage> {
  PageController pageController = PageController();
  BottomNavigationBar bottomNavigationBar;
  List<Widget> children;
  int pageSelected = 0;

  @override
  void initState() {
    super.initState();
    bottomNavigationBar = buildBottomNavigationBar();
    children = [HomePage(), ToDoListPage(), ProfilePage()];
  }

  void onPageChanged(int index) {
    setState(() {
      pageSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: children,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      //body: pageOptions[pageSelected],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // Create BottomNavigationBar
  BottomNavigationBar buildBottomNavigationBar() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: pageSelected,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          title: Text("Todo"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          title: Text("Profile"),
        ),
      ],
      onTap: (int index) {
        pageController.jumpToPage(index);
      },
    );
  }
}
