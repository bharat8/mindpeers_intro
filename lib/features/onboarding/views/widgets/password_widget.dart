import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/extensions/string_extensions.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_text_field.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key, required this.label,});
  final String label;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      label: widget.label,
      hintText: 'Something you can remember',
      inputType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () {
          showPassword = !showPassword;
          setState(() {});
        },
        child: showPassword
            ? const Icon(
                Icons.remove_red_eye_rounded,
                color: AppColors.primaryColor,
              )
            : const Icon(
                Icons.visibility_off,
                color: Colors.white,
              ),
      ),
      obscureText: !showPassword,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter your password';
        } else if (!val.isValidPassword) {
          return 'Please enter a valid password';
        }
        return null;
      },
      onChange: (val) {
        if (val != null) {
          context.read<OnboardingBloc>().add(
                SetPassword(password: val),
              );
        }
      },
    );
  }
}
