import 'package:flutter/material.dart';

enum PhaseState { Processing, Moving }

class PhaseAnimation extends StatefulWidget {
  final PhaseAnimationState phaseState = PhaseAnimationState();
  final Color dominantColor;

  PhaseAnimation(this.dominantColor);

  @override
  State<StatefulWidget> createState() => phaseState;

  void run() {
    phaseState.run();
  }

  void stop() {
    phaseState.stop();
  }

  void move(double dx) {
    phaseState.move(dx);
  }
}

class PhaseAnimationState extends State<PhaseAnimation>
    with TickerProviderStateMixin {
  PhaseState _phaseState;

  AnimationController _blinkController;
  Animation<double> _blinkAnimation;
  Animation<double> _opacityAnimation;

  AnimationController _moveController;
  Animation<Offset> _phasePosition;

  @override
  void initState() {
    super.initState();

    _phaseState = PhaseState.Processing;

    _blinkController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _blinkAnimation =
        CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut);
    _opacityAnimation =
        Tween<double>(begin: 0.4, end: 1).animate(_blinkController);

    _moveController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _blinkAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _blinkController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _blinkController.forward();
      }
    });
  }

  @override
  void dispose() {
    _blinkController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  void run() {
    _blinkController.forward();
  }

  void stop() {
    _blinkController.stop();
  }

  void move(double dx) {
    setState(() {
      _phaseState = PhaseState.Moving;
      _phasePosition = Tween<Offset>(begin: Offset.zero, end: Offset(dx, 0.0))
          .animate(_moveController);
      _moveController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(child: Text("a child"));
    var fadeTransition = new FadeTransition(
        opacity: _opacityAnimation,
        child: new Container(
          margin: const EdgeInsets.only(left: 9.0),
          width: 17.0,
          height: 17.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            gradient: new LinearGradient(
              begin: FractionalOffset.center,
              end: FractionalOffset.topCenter,
              colors: [widget.dominantColor, Colors.white],
            ),
          ),
        ));

    if (_phaseState == PhaseState.Processing) {
      return fadeTransition;
    } else {
      return new SlideTransition(
          position: _phasePosition, child: fadeTransition);
    }
  }
}
