import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;
  static bool holding = false;

  MyButton({this.child, this.function});

  bool isHolding() {
    return holding;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details){
        holding = true;
        function();
      },
      onTapUp: (details){
        holding = false;
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: child,
          )),
    );
  }
}
