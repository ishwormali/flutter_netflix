import 'package:flutter/material.dart';
import 'package:flutter_netflix/screens/main_screen.dart';
import 'package:flutter_netflix/screens/popcorn/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Netflix",
      theme: _buildTheme(ThemeData.dark()),
      routes: {
        "/": (context) {
          return Home();
        }
      },
    );
  }

  _buildTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
        primaryColor: Colors.redAccent,
        primaryTextTheme: _getTextTheme(baseTheme.primaryTextTheme),
        textTheme: _getTextTheme(baseTheme.textTheme),
        primaryIconTheme: _getIconTheme(baseTheme.primaryIconTheme),
        scaffoldBackgroundColor: Color(0XFF141414),
        canvasColor: Color(0XAA141414),
        iconTheme: _getIconTheme(baseTheme.iconTheme));
  }

  _getTextTheme(TextTheme baseTheme) {
    return baseTheme.copyWith(
        body1: baseTheme.body2.copyWith(fontSize: 12),
        body2: baseTheme.body2.copyWith(fontSize: 10),
        caption: baseTheme.caption.copyWith(fontSize: 12));
  }

  _getIconTheme(IconThemeData base) {
    return base.copyWith(size: 30, opacity: 1);
  }

  _getTextStyle() {
    return TextStyle(fontSize: 6, color: Colors.green);
  }
}
