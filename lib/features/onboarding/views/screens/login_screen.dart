import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/status/status.dart';
import 'package:mindpeers_intro/features/core/widgets/loading_indicator.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_button.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/home_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/signup_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/email_widget.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/login_signup_helper_text.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        listenWhen: (p, c) => p.loginStatus != c.loginStatus,
        listener: (context, state) {
          state.loginStatus.maybeWhen(
            orElse: () {},
            success: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ),
                (route) => false,
              );
            },
            failure: (f) {
              f?.maybeWhen(
                orElse: () {},
                value: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        error?.toString() ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.baseMargin * 4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'Welcome back, Log In to your account',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          verticalSpaceMedium,
                          const EmailWidget(),
                          verticalSpaceMedium,
                          const PasswordWidget(label: 'Password'),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpaceRegular,
                      PrimaryButton(
                        label: 'Log In',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<OnboardingBloc>().add(LogIn());
                          }
                        },
                      ),
                      verticalSpaceMedium,
                      LoginSignupHelperText(
                        label: "Don't have an account?",
                        actionText: 'Sign up',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (context) {
                                return const SignupScreen();
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
                if (state.loginStatus == const Status.loading()) {
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
