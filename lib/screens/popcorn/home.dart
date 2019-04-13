import 'package:flutter/material.dart';
import 'package:flutter_netflix/screens/popcorn/header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = 300;
    double width = MediaQuery.of(context).size.width;
    print("width" + width.toString());

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0XFFFBE8F1), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
          child: NestedScrollView(
        
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: appBarHeight,
              floating: false,
              pinned: false,
              flexibleSpace: 
              Container(child: Header ()),
              backgroundColor: Colors.transparent,
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}
