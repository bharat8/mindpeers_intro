import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/widgets/app_card_border.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPress,
  });
  final String label;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onPress.call();
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: UIConstants.baseMargin * 2.5,
              horizontal: UIConstants.baseMargin * 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                UIConstants.baseBorderRadius,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const AppCardBorder(),
        ],
      ),
    );
  }
}
