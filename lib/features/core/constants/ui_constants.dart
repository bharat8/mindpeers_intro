import 'package:flutter/cupertino.dart';

class UIConstants {
  //Margin
  static const double baseMargin = 8;

  //Border Radius
  static const double baseBorderRadius = 8;

  //Icon size
  static const double baseIconSize = 24;
}

const verticalSpaceSmall = SizedBox(height: UIConstants.baseMargin);
const verticalSpaceRegular = SizedBox(height: UIConstants.baseMargin * 2);
const verticalSpaceMedium = SizedBox(height: UIConstants.baseMargin * 4);
const verticalSpaceLarge = SizedBox(height: UIConstants.baseMargin * 6);

const horizontalSpaceSmall = SizedBox(width: UIConstants.baseMargin);
const horizontalSpaceRegular = SizedBox(width: UIConstants.baseMargin * 2);
const horizontalSpaceMedium = SizedBox(width: UIConstants.baseMargin * 4);
const horizontalSpaceLarge = SizedBox(width: UIConstants.baseMargin * 6);
