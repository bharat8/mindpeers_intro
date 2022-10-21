import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/status/status.dart';
import 'package:mindpeers_intro/features/core/widgets/loading_indicator.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_button.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/home_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/login_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/email_widget.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/login_signup_helper_text.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/password_valid_constraints.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/password_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (p, c) => p.signUpStatus != c.signUpStatus,
        listener: (context, state) {
          if (state.signUpStatus == const Status.success()) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
              (route) => false,
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.baseMargin * 4,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                'Create your account',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            verticalSpaceMedium,
                            const EmailWidget(),
                            verticalSpaceMedium,
                            const PasswordWidget(
                              label: 'Create Password',
                            ),
                            verticalSpaceMedium,
                            const PasswordValidConstraints(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpaceRegular,
                      PrimaryButton(
                        label: 'Sign Up',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<OnboardingBloc>().add(SignUp());
                          }
                        },
                      ),
                      verticalSpaceMedium,
                      LoginSignupHelperText(
                        label: 'Already have an account?',
                        actionText: 'Log In',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
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
                ],
              ),
            ),
            BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state.signUpStatus == const Status.loading()) {
                  return const LoadingIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
