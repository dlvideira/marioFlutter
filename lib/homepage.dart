import 'dart:async';

import 'package:first_app/button.dart';
import 'package:first_app/character/goomba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'character/mario.dart';
import 'character/shroom.dart';
import 'move/jump.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double goombaX = -0.7;
  double goombaY = 1;
  bool toggle = false;
  double marioSize = 50;
  double shroomX = 0.5;
  double shroomY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;
  int counter = 200;
  Timer timer;
  var gamefont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void checkEatShroom() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05)
      setState(() {
        shroomX = 2;
        marioSize = 100;
      });
  }

  void startTimer() {
    if (timer != null) timer.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0)
          counter--;
        else
          timer.cancel();
      });
    });
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (!midjump) {
      midjump = !midjump;
      preJump();
      Timer.periodic(Duration(milliseconds: 35), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
            timer.cancel();
          });
        } else
          setState(() {
            marioY = initialHeight - height;
          });
      });
    }
  }

  void moveRight() {
    direction = "right";
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkEatShroom();
      if (MyButton.holding && (marioX + 0.02 < 1)) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else
        timer.cancel();
    });
  }

  void moveLeft() {
    direction = "left";
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkEatShroom();
      if (MyButton.holding && (marioX - 0.02 > -1)) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else
        timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              Container(
                // color: Colors.blue,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('lib/resources/images/bgup.png'),
                  fit: BoxFit.cover,
                )),
                child: AnimatedContainer(
                  alignment: Alignment(marioX, marioY),
                  duration: Duration(milliseconds: 0),
                  child: midjump
                      ? Jump(
                          direction: direction,
                          size: marioSize,
                        )
                      : MyMario(
                          direction: direction,
                          midrun: midrun,
                          size: marioSize,
                        ),
                ),
              ),
              Container(
                alignment: Alignment(shroomX, shroomY),
                child: Shroom(),
              ),
              Container(
                child: AnimatedContainer(
                  alignment: Alignment(goombaX, goombaY),
                  duration: Duration(milliseconds: 100),
                  child: Goomba(toggle: toggle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("MARIO", style: gamefont),
                        SizedBox(height: 10),
                        Text("0000", style: gamefont),
                      ],
                    ),
                    Column(
                      children: [
                        Text("WORLD", style: gamefont),
                        SizedBox(height: 10),
                        Text("1-1", style: gamefont),
                      ],
                    ),
                    Column(
                      children: [
                        Text("TIME", style: gamefont),
                        SizedBox(height: 10),
                        Text('$counter', style: gamefont),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              //color: Colors.brown,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/resources/images/bgdown.png'),
                fit: BoxFit.cover,
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(Icons.arrow_back),
                    function: moveLeft,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_upward),
                    function: jump,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_forward),
                    function: moveRight,
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
