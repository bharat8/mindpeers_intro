import 'package:flutter/material.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_button.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/login_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/signup_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/login_signup_helper_text.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.baseMargin * 4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hi, Welcome',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  verticalSpaceRegular,
                  Text(
                    'Begin your journey with '
                    'mental strength through this portal',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  verticalSpaceMedium,
                  PrimaryButton(
                    label: 'Create an account',
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return const SignupScreen();
                          },
                        ),
                      );
                    },
                  ),
                  verticalSpaceMedium,
                  LoginSignupHelperText(
                    label: 'Already have an account?',
                    actionText: 'Log In',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  verticalSpaceLarge,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
