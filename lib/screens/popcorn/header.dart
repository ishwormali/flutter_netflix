import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: -200,
            top: -145,
            // height: 330,
            // width: 572,
            child: HeaderCircle(
                width: 572, height: 330, color: Color(0XFFF1C8DB))),
        Positioned(
            left: -200,
            top: -155,
            // height: 330,
            // width: 476,
            child: HeaderCircle(
                width: 476, height: 330, color: Color(0XFFB88C9E))),
        Positioned(
            left: -200,
            top: -165,
            // height: 330,
            // width: 400,
            child:
                HeaderCircle(width: 400, height: 330, color: Color(0XFF704C5E)))
        // HeaderCircle(width: 571,color: Color(0XF1C8DB))
      ],
    );
  }
}

class HeaderCircle extends StatelessWidget {
  double height = 20;
  double width;
  Color color;
  HeaderCircle({this.width, this.height, this.color}) : super();

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: ClipOval(
        child: Container(
          height: this.height,
          width: this.width,
          child: Text("circle"),
          color: this.color,
        ),
      ),
    );
  }
}
