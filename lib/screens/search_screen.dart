import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlowExample(),
    );
  }
}

class FlowExample extends StatefulWidget {
  _FlowExampleState createState() => _FlowExampleState();
}

class _FlowExampleState extends State<FlowExample>
    with SingleTickerProviderStateMixin {
  AnimationController openAnimation;

  @override
  void initState() {
    super.initState();
    openAnimation = AnimationController(
      lowerBound: 1,
      upperBound: 10,
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  double initial = 0.0;

  final List<String> list = <String>[
    "Home",
    "Feed",
    "Chat",
    "Settings",
    "About"
  ];

  Widget buildItem(String i) {
    return GestureDetector(
      onTap: () {
        openAnimation.reverse();
      },
      onDoubleTap: () {
        openAnimation.forward();
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [BoxShadow(blurRadius: 2)],
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(i),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.blueGrey,
            child: Flow(
              delegate: SampleFlowDelegate(openAnimation: openAnimation),
              children: list.map<Widget>((i) => buildItem(i)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class SampleFlowDelegate extends FlowDelegate {
  SampleFlowDelegate({this.openAnimation}) : super(repaint: openAnimation);

  final Animation<double> openAnimation;

  @override
  bool shouldRepaint(SampleFlowDelegate oldDelegate) {
    return openAnimation != oldDelegate.openAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dy = context.getChildSize(i).height * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0,
          dy * 0.1 * openAnimation.value,
          0,
        ),
      );
    }
  }
}
