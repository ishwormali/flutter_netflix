import 'package:flutter/material.dart';
import 'package:flutter_netflix/components/custom_app_bar.dart';

class MenuBar extends StatefulWidget {
  List<Menu> menus;
  MenuBar({@required this.menus});
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with TickerProviderStateMixin {
  AnimationController _controller;
  final _opacityTween = Tween<double>(begin: 1, end: 0);
  Animation<double> _opacityAnimation;
  Animation<double> _offsetAnimation;
  Animation<Alignment> _alignmentOffset;

  CustomContext menuContext =
      new CustomContext(selectedMenu: null, isCollapsed: false);
  Menu _selectedMenu;

  _MenuBarState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _opacityAnimation = _opacityTween.animate(CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.00, 0.50, curve: Curves.linear)
        // curve: Curves.ease
        ));
    _offsetAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _alignmentOffset = AlignmentTween(
            begin: FractionalOffset(0, 0), end: Alignment.centerLeft)
        .animate(
            new CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
  }
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getMenuBar(context),
    );
  }

  Widget _getMenuBar(BuildContext context) {
    return Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width - 90,
        height: 100,
        // child: Flow(
        //   children: [
        //     Container(
        //         // width: 10,
        //         // height: 100,
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.black, width: 1),
        //           boxShadow: [BoxShadow(blurRadius: 2)],
        //         ),
        //         child: FittedBox(
        //           child: Center(
        //             child: Text(
        //               "abcedddf",
        //               style: TextStyle(color: Colors.green),
        //             ),
        //           ),
        //         ))
        //   ],
        //   delegate: MenuDelegate(),
        // ),
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: _getMenus(context),
        // ),
        // child: Flow(
        //   children: _getMenus(context),
        //   delegate: MenuDelegate(),
        // )
        child: LayoutBuilder(
          builder: (BuildContext buildContext, BoxConstraints constraints) {
            List<Widget> menus = _getMenus(buildContext);
            double left = 0;
            return Stack(
                children: menus.map((m) {
              Widget w = Positioned(child: m, left: left);
              left = left + 100;
              return w;
            }).toList());
          },
        ));
  }

  List<Widget> _getMenus(BuildContext context) {
    return widget.menus.map((menu) {
      final widg = MenuControl(
          menu: menu,
          controller: this._controller,
          child: Text(
            menu.title,
            // style: Theme.of(context).textTheme.button,
          ),
          onPressed: _onPressed);

      return widg;
    }).toList();
  }

  void _onPressed(Menu menu) {
    bool shouldReverse = this._selectedMenu == menu;
    this.setState(() => {this._selectedMenu = menu});

    // if (_opacityAnimation.value == 0) {
    //   _opacityController.forward();
    // }
    if (shouldReverse) {
      _controller.reverse();
      this._selectedMenu = null;
    } else {
      _controller.forward();
    }
  }

  // Widget _getMenus(BuildContext context, BoxConstraints constraints) {
  //   double currentOffset = 10;
  //   return Stack(
  //       children: widget.menus.map((menu) {
  //     final widg = MenuControl(
  //         menu: menu,
  //         controller: null,
  //         child: Text(menu.title),
  //         left: currentOffset);
  //     currentOffset += 100;

  //     return widg;
  //   }).toList());
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class MenuDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      print("printing child" + i.toString() + " at " + dx.toString());

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0,
          0,
          0,
        ),
      );
      dx = dx + 60;
      // dx = context.getChildSize(i).width + dx;
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class MenuControl extends StatelessWidget {
  AnimationController controller;
  Widget child;
  Menu menu;
  double left;

  @required
  Function onPressed;
  final _opacityTween = Tween<double>(begin: 1, end: 0);
  Animation<double> _opacityAnimation;
  MenuControl(
      {@required this.controller,
      @required this.menu,
      @required this.child,
      this.left,
      this.onPressed}) {
    _opacityAnimation = _opacityTween.animate(CurvedAnimation(
        parent: this.controller,
        curve: new Interval(0.00, 0.50, curve: Curves.linear)));
  }

  @override
  Widget build(BuildContext context) {
    // return child;
    return Opacity(
      opacity: _opacityAnimation.value,
      child: FlatButton(
          // padding: EdgeInsets.all(5),
          child: child,
          onPressed: () {
            this.onPressed(this.menu);
          }),
    );
    // TODO: implement build
    // return FittedBox(
    //   child: child,
    //   // onPressed: () {},
    // );
    // return Positioned(
    //   left: this.left,
    //   child: child,
    // );
  }
}
