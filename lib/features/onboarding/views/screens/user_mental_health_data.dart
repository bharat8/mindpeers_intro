import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/constants/enums.dart';
import 'package:mindpeers_intro/features/core/constants/ui_constants.dart';
import 'package:mindpeers_intro/features/core/widgets/loading_indicator.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/home_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/login_signup_intro_screen.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/mountain_ball_anim.dart';
import 'package:mindpeers_intro/features/onboarding/views/widgets/option_widget.dart';
import 'package:sizer/sizer.dart';

class UserMentalHealthData extends StatefulWidget {
  const UserMentalHealthData({super.key});

  @override
  State<UserMentalHealthData> createState() => _UserMentalHealthDataState();
}

class _UserMentalHealthDataState extends State<UserMentalHealthData> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bloc = context.read<OnboardingBloc>();
        if (bloc.state.currentQuestion >= 0) {
          context.read<OnboardingBloc>().add(
                const SetQuestion(
                  ballDirection: BallDirection.backward,
                  selectedAnsIndex: -1,
                ),
              );
        }
        return false;
      },
      child: Scaffold(
        body: BlocListener<OnboardingBloc, OnboardingState>(
          listenWhen: (p, c) =>
              p.changeQuestionStatus != c.changeQuestionStatus,
          listener: (context, state) async {
            if (state.currentQuestion > state.quesAnsList.length - 1) {
              await Future.delayed(const Duration(seconds: 1), () {});

              if (!mounted) return;

              await Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const LoginSignupIntroScreen();
                  },
                ),
                (route) => false,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: SizedBox(
              width: 100.w,
              child: Stack(
                children: [
                  Column(
                    children: [
                      BlocBuilder<OnboardingBloc, OnboardingState>(
                        builder: (context, state) {
                          return LinearProgressIndicator(
                            value: state.quesAnsList.isNotEmpty
                                ? state.currentQuestion /
                                    state.quesAnsList.length
                                : 0,
                            backgroundColor: Colors.white,
                            color: AppColors.secondaryColor,
                            minHeight: 15,
                          );
                        },
                      ),
                      verticalSpaceRegular,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: UIConstants.baseMargin * 4,
                          ),
                          child: BlocBuilder<OnboardingBloc, OnboardingState>(
                            builder: (context, state) {
                              if (state.currentQuestion >
                                  state.quesAnsList.length - 1) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  verticalSpaceRegular,
                                  Text(
                                    state.quesAnsList[state.currentQuestion]
                                        .question,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  verticalSpaceMedium,
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: state
                                            .quesAnsList[state.currentQuestion]
                                            .answers
                                            .map((answer) {
                                          return OptionWidget(
                                            text: answer,
                                            isSelected: state
                                                    .quesAnsList[
                                                        state.currentQuestion]
                                                    .selectedAnsIndex ==
                                                state
                                                    .quesAnsList[
                                                        state.currentQuestion]
                                                    .answers
                                                    .indexOf(answer),
                                            onSelected: () {
                                              HapticFeedback.lightImpact();
                                              context
                                                  .read<OnboardingBloc>()
                                                  .add(
                                                    SetQuestion(
                                                      ballDirection:
                                                          BallDirection.forward,
                                                      selectedAnsIndex: state
                                                          .quesAnsList[state
                                                              .currentQuestion]
                                                          .answers
                                                          .indexOf(answer),
                                                    ),
                                                  );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<OnboardingBloc, OnboardingState>(
                        buildWhen: (p, c) =>
                            p.changeQuestionStatus != c.changeQuestionStatus,
                        builder: (context, state) {
                          return MountainBallAnim(
                            ballDirection: state.ballDirection,
                            totalSteps: state.quesAnsList.length,
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<OnboardingBloc, OnboardingState>(
                    builder: (context, state) {
                      if (state.currentQuestion == state.quesAnsList.length) {
                        return const LoadingIndicator();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
