import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Stack(
        children: const [
          SizedBox.expand(
            child: ColoredBox(
              color: Colors.black45,
            ),
          ),
          SpinKitDoubleBounce(
            color: Colors.white,
            size: UIConstants.baseIconSize * 2,
          ),
        ],
      ),
    );
  }
}
