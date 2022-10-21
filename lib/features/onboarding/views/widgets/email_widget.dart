import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/extensions/string_extensions.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_text_field.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      label: 'Email',
      hintText: 'johndoe@gmail.com',
      inputType: TextInputType.emailAddress,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter your email address';
        } else if (!val.isValidEmail) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onChange: (val) {
        if (val != null) {
          context.read<OnboardingBloc>().add(
                SetEmailId(emailId: val),
              );
        }
      },
    );
  }
}
