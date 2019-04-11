import 'package:flutter/material.dart';
import 'package:flutter_netflix/components/custom_app_bar_test.dart';
import 'package:flutter_netflix/screens/downloads_screen.dart';
import 'package:flutter_netflix/screens/home_screen.dart';
import 'package:flutter_netflix/screens/more_screen.dart';
import 'package:flutter_netflix/screens/search_screen.dart';
import 'package:flutter_netflix/screens/upcomming_screen.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  MainScreen({Key key, this.child}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _views = [
    HomeScreen(),
    SearchScreen(),
    UpCommingScreen(),
    Downloads(),
    // CustomSizedAppBar()
    MoreScreen()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _existingStyle = Theme.of(context).textTheme.caption;
    TextStyle _textStyle = TextStyle(fontSize: _existingStyle.fontSize);
    return Scaffold(
        body: Center(child: _getView(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text("Home", style: _textStyle),
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: Text("Search", style: _textStyle)),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.movie),
                title: Text("Coming soon", style: _textStyle)),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.file_download),
                title: Text("Downloads", style: _textStyle)),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.more_horiz),
                title: Text("More", style: _textStyle))
          ],
          currentIndex: _selectedIndex,
          onTap: _onTabbed,
          type: BottomNavigationBarType.fixed,
        ));
  }

  _onTabbed(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  _getView(int idx) {
    return _views[idx];
  }
}
