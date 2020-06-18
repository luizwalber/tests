import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:test_flare/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> animations = [
    Constants.ANIMATION_NIGHT_IDLE,
    Constants.ANIMATION_NIGHT_TO_DAY,
    Constants.ANIMATION_DAY_IDLE,
    Constants.ANIMATION_DAY_TO_NIGHT,
  ];

  int animationIndex;
  bool isAnimating;

  @override
  void initState() {
    animationIndex = 0;
    isAnimating = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundFlare(context),
        _flareButton(),
      ],
    );
  }

  Widget _backgroundFlare(context) {
    return FlareActor(
      Constants.FLARE_BACKGROUND,
      animation: animations[animationIndex],
      fit: BoxFit.fill,
      callback: (name) {
        finishChanging();
      },
    );
  }

  Widget _flareButton() {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: GestureDetector(
            onTap: () => changeBackground(),
            child: FlareActor(
              Constants.FLARE_CHANGE_THEME_BUTTON,
              animation: animations[animationIndex],
            )),
      ),
    );
  }

  void changeBackground() {
    if (isAnimating) {
      return;
    } else {
      isAnimating = true;
    }

    _increaseAnimation();
  }

  void finishChanging() {
    setState(() {
      isAnimating = false;
    });
    _increaseAnimation();
  }

  void _increaseAnimation() {
    setState(() {
      animationIndex = (animationIndex + 1) % 4;
    });
  }
}
