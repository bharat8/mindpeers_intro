import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';

class LoginSignupHelperText extends StatelessWidget {
  const LoginSignupHelperText({
    super.key,
    required this.label,
    required this.actionText,
    required this.onTap,
  });
  final String label;
  final String actionText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
        horizontalSpaceSmall,
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap.call();
          },
          child: Text(
            actionText,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
