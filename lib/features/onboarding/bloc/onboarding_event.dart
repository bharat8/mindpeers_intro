part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class SetEmailId extends OnboardingEvent {
  const SetEmailId({
    required this.emailId,
  });

  final String emailId;

  @override
  List<Object> get props => [emailId];
}

class SetPassword extends OnboardingEvent {
  const SetPassword({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class SignUp extends OnboardingEvent {}

class LogIn extends OnboardingEvent {}

class LoadQuiz extends OnboardingEvent {}

class SetQuestion extends OnboardingEvent {
  const SetQuestion({
    required this.ballDirection,
    required this.selectedAnsIndex,
  });

  final BallDirection ballDirection;
  final int selectedAnsIndex;

  @override
  List<Object> get props => [ballDirection, selectedAnsIndex];
}
