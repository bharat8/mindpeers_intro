import 'package:flutter/material.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/widgets/app_card_border.dart';
import 'package:sizer/sizer.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onSelected,
  });
  final String text;
  final bool isSelected;
  final void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: UIConstants.baseMargin * 3,
      ),
      child: GestureDetector(
        onTap: onSelected,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 10.h,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.baseMargin * 2,
                vertical: UIConstants.baseMargin,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(
                  UIConstants.baseBorderRadius,
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  maxLines: 10,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey[850],
                        fontWeight: FontWeight.w500,
                      ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (isSelected) const AppCardBorder(),
          ],
        ),
      ),
    );
  }
}
