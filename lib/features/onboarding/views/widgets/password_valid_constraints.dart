import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/extensions/string_extensions.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';

class PasswordValidConstraints extends StatefulWidget {
  const PasswordValidConstraints({
    super.key,
  });

  @override
  State<PasswordValidConstraints> createState() =>
      _PasswordValidConstraintsState();
}

class _PasswordValidConstraintsState extends State<PasswordValidConstraints> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            PasswordValidConstraintsWidget(
              label: 'At least 8 characters',
              valid: state.password.hasAtLeast8Chars,
            ),
            verticalSpaceRegular,
            PasswordValidConstraintsWidget(
              label: 'One number & One capital letter',
              valid: state.password.hasOneNumAndOneLetter,
            ),
            verticalSpaceRegular,
            PasswordValidConstraintsWidget(
              label: r'One symbol eg: @#!$%^&*',
              valid: state.password.hasOneSpecialChar,
            ),
          ],
        );
      },
    );
  }
}

class PasswordValidConstraintsWidget extends StatelessWidget {
  const PasswordValidConstraintsWidget({
    super.key,
    required this.label,
    required this.valid,
  });

  final String label;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          !valid ? Icons.adjust : Icons.check_circle,
          size: UIConstants.baseIconSize * 0.7,
          color: valid ? Colors.green : null,
        ),
        horizontalSpaceSmall,
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
