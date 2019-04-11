import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  List<Menu> menus = List<Menu>();
  CustomAppBar({this.menus});
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final _opacityTween = Tween<double>(begin: 1, end: 0);
  Animation<double> _opacityAnimation;
  Animation<Offset> _offsetAnimation;
  Animation<Alignment> _alignmentOffset;

  CustomContext menuContext =
      new CustomContext(selectedMenu: null, isCollapsed: false);
  Menu _selectedMenu;
  _CustomAppBarState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _opacityAnimation = _opacityTween.animate(CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.00, 0.50, curve: Curves.linear)
        // curve: Curves.ease
        ));
    _offsetAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
        .animate(_controller);
    _alignmentOffset = AlignmentTween(
            begin: FractionalOffset(0, 0), end: Alignment.centerLeft)
        .animate(
            new CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
    // _alignmentAnimation =
    //     new Tween<Offset>(begin: new Offset(0, 0), end: Offset(-2, 0)).animate(
    //         CurvedAnimation(
    //             parent: _controller,
    //             curve: new Interval(0.50, 1.0, curve: Curves.linear)
    //             // curve: Curves.ease
    //             ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    // _offsetAnimation.addListener(() {
    //   setState(() {});
    // });
    // _opacityController.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> allWidgets = List<Widget>();
    for (int idx = 0; idx < widget.menus.length; idx++) {
      allWidgets.add(
          _getAppButton(widget.menus[idx], context, this._selectedMenu, idx));
    }
    // print(this._opacityController);
    // return Text("custom app");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: allWidgets,
    );
  }

  Widget _getAppButton(
      Menu menu, BuildContext context, Menu selectedMenu, int idx) {
    Widget childWidget = _getMenuButton(menu, context, selectedMenu, idx);
    // print(_opacityAnimation.value);
    // if (_opacityController.isAnimating) {
    return _getAnimatedAppButton(menu, context, selectedMenu, childWidget);
    // } else {
    //   return childWidget;
    // }

    // return Opacity(
    //   opacity: selectedMenu == null || selectedMenu.title == menu.title
    //       ? 1
    //       : _opacityAnimation.value,
    //   child: _getMenuButton(menu, context, selectedMenu),
    // );
  }

  Widget _getAnimatedAppButton(
      Menu menu, BuildContext context, Menu selectedMenu, Widget child) {
    // print(_opacityAnimation.value);

    if (menu == selectedMenu) {
      print("offsetanimation value " + _offsetAnimation.value.dx.toString());
      return SlideTransition(
          position: _offsetAnimation,
          // sizeFactor: _offsetAnimation,
          // axis: Axis.horizontal,
          // key: Key("sdf"),
          // alignment: _alignmentOffset,
          // alignment: Alignment.topLeft, // _alignmentAnimation.value,
          child:
              child); //DecoratedBoxTransition(child: child, decoration: _opacityAnimation,);
    } else {
      return Opacity(
        opacity: _opacityAnimation.value,
        child: child,
      );
    }
  }

  Widget _getMenuButton(
      Menu menu, BuildContext context, Menu selectedMenu, int idx) {
    return FlatButton(
        splashColor: Colors.transparent,
        child: Text(menu.title),
        onPressed: () => onMenuSelected(menu, idx));
  }

  onMenuSelected(Menu menu, int idx) {
    setState(() {
      bool shouldReverse = this._selectedMenu == menu;
      this.setState(() => {this._selectedMenu = menu});

      // if (_opacityAnimation.value == 0) {
      //   _opacityController.forward();
      // }
      if (shouldReverse) {
        _controller.reverse();
        this._selectedMenu = null;
      } else {
        _offsetAnimation =
            Tween<Offset>(begin: Offset(0, 0), end: Offset(-1.0 * idx, 0))
                .animate(CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0.5, 1.0, curve: Curves.easeOut)));
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class Menu {
  String title;
  Menu({this.title});
}

class MenuItem {
  String title;
  MenuItem({this.title});
}

class CustomContext {
  Menu selectedMenu;
  bool isCollapsed;
  CustomContext({this.selectedMenu, this.isCollapsed});
}
