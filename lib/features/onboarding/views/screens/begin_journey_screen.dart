import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/status/status.dart';
import 'package:mindpeers_intro/features/core/widgets/loading_indicator.dart';
import 'package:mindpeers_intro/features/core/widgets/primary_button.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/user_mental_health_data.dart';
import 'package:sizer/sizer.dart';

class BeginJourneyScreen extends StatelessWidget {
  const BeginJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (p, c) => p.quesAnsLoadStatus != c.quesAnsLoadStatus,
        listener: (context, state) {
          if (state.quesAnsLoadStatus == const Status.success()) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) {
                  return const UserMentalHealthData();
                },
              ),
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: SvgPicture.asset(
                          'assets/images/mountain-withball.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: UIConstants.baseMargin * 4,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'MindPeers Signature\nMental Strength Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              verticalSpaceRegular,
                              Text(
                                'Discover your strengths and identify '
                                'growth areas in under 4 minutes',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              verticalSpaceLarge,
                              PrimaryButton(
                                label: 'Begin journey',
                                onPress: () {
                                  context
                                      .read<OnboardingBloc>()
                                      .add(LoadQuiz());
                                },
                              ),
                              verticalSpaceLarge,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state.quesAnsLoadStatus == const Status.loading()) {
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
