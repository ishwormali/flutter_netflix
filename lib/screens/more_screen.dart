import 'package:flutter/material.dart';
import 'package:flutter_netflix/components/done_animation.dart';
import 'package:flutter_netflix/components/phase_animation.dart';
import 'package:flutter_netflix/components/progress_button.dart';

class MoreScreen extends StatefulWidget {
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String buttonText = "START";
  PhaseAnimation phaseOne;
  PhaseAnimation phaseTwo;
  PhaseAnimation phaseThree;

  bool showCheckIcon = false;

  _MoreScreenState() {
    phaseOne = PhaseAnimation(Colors.red);
    print("phaseone");
    print(phaseOne);
    phaseTwo = new PhaseAnimation(Colors.yellow);
    phaseThree = new PhaseAnimation(Colors.green);
  }
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(phaseOne);
    return Container(
        // child: Center(
        child: new ProgressButton(
      child: new Row(children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(left: 30.0, right: 85),
          width: 100.0,
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
        ),
        Visibility(
          visible: !showCheckIcon,
          child: new Row(
            children: <Widget>[
              // Text("test")
              phaseOne,
              phaseTwo,
              phaseThree,
            ],
          ),
        ),
        Visibility(visible: showCheckIcon, child: DoneAnimation())
      ]),
      onPressed: () async {
        phaseOne.run();
        setState(() {
          buttonText = "PHASE 1";
        });
        await Future.delayed(const Duration(milliseconds: 2500));
        phaseTwo.run();
        setState(() {
          buttonText = "PHASE 2";
        });
        phaseOne.stop();
        await Future.delayed(const Duration(milliseconds: 2500));
        phaseThree.run();
        setState(() {
          buttonText = "PHASE 3";
        });
        phaseTwo.stop();
        await Future.delayed(const Duration(milliseconds: 2500));
        phaseThree.stop();

        phaseOne.move(2.0);
        phaseTwo.move(1.0);

        await Future.delayed(const Duration(milliseconds: 1000));
        setState(() {
          showCheckIcon = true;
          buttonText = "DONE!";
        });
      },
    ));
  }
}
