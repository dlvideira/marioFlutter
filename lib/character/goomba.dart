import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Goomba extends StatelessWidget {
  final toggle;

  Goomba({this.toggle});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(toggle == true ? pi : 0),
      child: Container(
          height: 35, width: 35, child: Image.asset('lib/resources/images/goomba.png')),
    );
  }
}
