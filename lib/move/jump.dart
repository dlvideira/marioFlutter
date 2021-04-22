import 'dart:math';

import 'package:flutter/material.dart';

class Jump extends StatelessWidget {
  final direction;
  final size;

  Jump({this.direction, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
          height: size, width: size,
          child: Image.asset('lib/resources/images/jump.png'));
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
            height: size,
            width: size,
            child: Image.asset('lib/resources/images/jump.png')),
      );
    }
  }
}