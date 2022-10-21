import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindpeers_intro/features/core/constants/enums.dart';
import 'package:sizer/sizer.dart';

class MountainBallAnim extends StatefulWidget {
  const MountainBallAnim({
    super.key,
    required this.ballDirection,
    required this.totalSteps,
  });
  final BallDirection ballDirection;
  final int totalSteps;

  @override
  State<MountainBallAnim> createState() => _MountainBallAnimState();
}

class _MountainBallAnimState extends State<MountainBallAnim> {
  late double bottomFactor;
  late double leftFactor;

  late double positionFromBottom;
  late double positionFromLeft;

  @override
  void initState() {
    positionFromBottom = 9.5.h;
    positionFromLeft = 10.w;

    bottomFactor = (35.h - 9.5.h) / widget.totalSteps;
    leftFactor = (65.w - 10.w) / widget.totalSteps;
    super.initState();
  }

  void updateValues() {
    if (widget.ballDirection != BallDirection.none) {
      if (widget.ballDirection == BallDirection.forward) {
        positionFromBottom += bottomFactor;
        positionFromLeft += leftFactor;
      } else {
        positionFromBottom -= bottomFactor;
        positionFromLeft -= leftFactor;
      }
    }
  }

  @override
  void didUpdateWidget(covariant MountainBallAnim oldWidget) {
    updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/mountain.svg',
            height: 40.h,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            bottom: positionFromBottom,
            left: positionFromLeft,
            curve: Curves.decelerate,
            child: SvgPicture.asset(
              'assets/images/ball.svg',
            ),
          ),
        ],
      ),
    );
  }
}
