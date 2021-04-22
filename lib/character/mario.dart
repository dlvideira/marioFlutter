import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final size;
  final midrun;
  final midjump;

  MyMario({this.direction, this.midrun, this.midjump, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
          height: size, width: size,
          child: midrun ? Image.asset('lib/resources/images/stand.png') : Image.asset('lib/resources/images/running.png'));
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
            height: size,
            width: size,
            child: midrun ? Image.asset('lib/resources/images/stand.png') : Image.asset('lib/resources/images/running.png')),
      );
    }
  }
}
