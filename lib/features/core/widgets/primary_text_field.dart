import 'package:flutter/material.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.label = '',
    this.hintText,
    this.inputType,
    this.enabled = true,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onChange,
  });
  final String label;
  final String? hintText;
  final TextInputType? inputType;
  final bool enabled;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onChange;

  UnderlineInputBorder get textFieldBorder => UnderlineInputBorder(
        borderRadius: BorderRadius.circular(
          UIConstants.baseBorderRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 6,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        verticalSpaceSmall,
        ClipRRect(
          borderRadius: BorderRadius.circular(
            UIConstants.baseBorderRadius,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: UIConstants.baseMargin * 2,
                vertical: UIConstants.baseMargin * 2,
              ),
              filled: true,
              fillColor: AppColors.cardColor,
              enabled: enabled,
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
              disabledBorder: textFieldBorder,
              errorBorder: textFieldBorder,
              suffixIcon: suffixIcon,
              focusedErrorBorder: textFieldBorder,
            ),
            obscureText: obscureText,
            obscuringCharacter: '*',
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1.5,
            keyboardType: inputType,
            validator: validator,
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
