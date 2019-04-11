import 'package:flutter/material.dart';
import 'package:flutter_netflix/components/custom_app_bar.dart';
import 'package:flutter_netflix/components/menu_bar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.65;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: appBarHeight,
            floating: false,
            pinned: false,
            flexibleSpace: Stack(
              children: <Widget>[
                FlexibleSpaceBar(background: _getBackgroundImage(context)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: _getCoverActionBar(context),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.transparent,
            title: Row(children: [
              // MenuBar(menus: [
              //   Menu(title: "Tv Shows"),
              //   Menu(title: "Movies"),
              //   Menu(title: "My List")
              // ])
              Image.asset("assets/icons/Netflix-Icon-PNG-image.png"),
              Padding(padding: EdgeInsets.all(5)),
              CustomAppBar(
                menus: [
                  Menu(title: "Tv Shows"),
                  Menu(title: "Movies"),
                  Menu(title: "My List")
                ],
              )
            ]),
          ),
          // Container(
          //   color: Colors.green,
          // )
        ];
      },
      body: Center(child: Text("HOME SCREEN!!")
          // Image.network(
          //     "https://occ-0-1882-2567.1.nflxso.net/art/c699a/a5fd27d87a82ca56ff979db67434525d71ac699a.webp",
          //     fit: BoxFit.cover)
          ),
    );
  }

  Widget _getCoverActionBar(BuildContext context) {
    return Container(
        // color: Colors.red,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.add),
              Padding(padding: EdgeInsets.all(1)),
              Text("My List"),
            ],
          ),
          onPressed: () => {},
        ),
        FlatButton(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              padding: EdgeInsets.all(8),
              width: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.play_arrow, color: Colors.black),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Play",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
          onPressed: () => {},
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.info_outline,
              ),
              Padding(padding: EdgeInsets.all(1)),
              Text("Info"),
            ],
          ),
          onPressed: () => {},
        )
      ],
    ));
  }

  Widget _getBackgroundImage(BuildContext context) {
    return DecoratedBox(
        // decoration: BoxDecoration(color: Colors.white),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              .8,
              1
            ],
                colors: [
              const Color(0x00001510),
              Theme.of(context).scaffoldBackgroundColor
            ])),
        position: DecorationPosition.foreground,
        child: Image.network(
          "https://fontmeme.com/images/Gravity-Poster.jpg",
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
          // color: Theme.of(context).scaffoldBackgroundColor,
          // colorBlendMode: BlendMode.overlay,
        ));
  }
}
