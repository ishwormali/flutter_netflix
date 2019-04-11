import 'package:flutter/material.dart';

class CustomSizedAppBar extends StatefulWidget {
  final Widget child;

  CustomSizedAppBar({Key key, this.child}) : super(key: key);

  _CustomSizedAppBarState createState() => _CustomSizedAppBarState();
}

class _CustomSizedAppBarState extends State<CustomSizedAppBar>
    with TickerProviderStateMixin {
  int _pressedButton = -1;
  bool _buttonSelected = false;

  Animation<double> _animationFadeOut;
  AnimationController _controllerFadeOut;
  Animation<double> _animationSlideLeft;
  AnimationController _controllerSlideLeft;

  @override
  void initState() {
    super.initState();
    _initFadeOutAnimation();
    _initSlideLeftAnimation();
  }

  void _initFadeOutAnimation() {
    _controllerFadeOut = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controllerFadeOut,
            curve: Interval(0, 0.5, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          if (_controllerFadeOut.isCompleted &&
              !_controllerSlideLeft.isAnimating) {
            // _controllerSlideLeft.forward();
          }
        });
      });
  }

  void _initSlideLeftAnimation() {
    _controllerSlideLeft = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationSlideLeft = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controllerFadeOut,
            curve: Interval(0.5, 1, curve: Curves.easeInOut)))
      ..addListener(() {
        setState(() {
          if (_controllerFadeOut.isCompleted) {
            _buttonSelected = true;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Column(children: <Widget>[
          _buttonsWidget(),
          Text(_pressedButton != null
              ? "$_pressedButton button pressed"
              : "No button pressed"),
          RaisedButton(
              child: Text("Reset"),
              onPressed: () {
                _controllerFadeOut.reset();
                _controllerSlideLeft.reset();
                _pressedButton = -1;
                _buttonSelected = false;
              })
        ]));
  }

  Widget _buttonsWidget() {
    if (_buttonSelected) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_buttonWidget(_pressedButton)]);
    } else {
      return Row(children: <Widget>[
        _animatedButtonWidget(1),
        _animatedButtonWidget(2),
        _animatedButtonWidget(3),
        _animatedButtonWidget(4)
      ]);
    }
  }

  Widget _animatedButtonWidget(int button) {
    if (button == _pressedButton) {
      return _buttonWidget(button);
    } else {
      return SizeTransition(
          sizeFactor: _animationSlideLeft,
          axis: Axis.horizontal,
          child: Opacity(
              opacity: _animationFadeOut.value, child: _buttonWidget(button)));
    }
  }

  Widget _buttonWidget(int button) {
    return RaisedButton(
        onPressed: () => _onButtonClick(button), child: Text("Button $button"));
  }

  void _onButtonClick(int button) {
    setState(() {
      _pressedButton = button;
    });
    _controllerFadeOut.forward();
  }
}
