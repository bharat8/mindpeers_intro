part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.emailId = '',
    this.password = '',
    this.signUpStatus = const Status.initial(),
    this.loginStatus = const Status.initial(),
    this.token = '',
    this.currentQuestion = 0,
    this.ballDirection = BallDirection.none,
    this.quesAnsList = const [],
    this.changeQuestionStatus = const Status.initial(),
    this.quesAnsLoadStatus = const Status.initial(),
  });

  final String emailId;
  final String password;

  final Status signUpStatus;
  final Status loginStatus;
  final String token;

  final BallDirection ballDirection;
  final int currentQuestion;
  final Status changeQuestionStatus;

  final List<QuesAnsModel> quesAnsList;
  final Status quesAnsLoadStatus;

  OnboardingState copyWith({
    String? emailId,
    String? password,
    Status? signUpStatus,
    Status? loginStatus,
    String? token,
    BallDirection? ballDirection,
    int? currentQuestion,
    Status? changeQuestionStatus,
    List<QuesAnsModel>? quesAnsList,
    Status? quesAnsLoadStatus,
  }) {
    return OnboardingState(
      emailId: emailId ?? this.emailId,
      password: password ?? this.password,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      token: token ?? this.token,
      ballDirection: ballDirection ?? this.ballDirection,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      changeQuestionStatus: changeQuestionStatus ?? this.changeQuestionStatus,
      quesAnsList: quesAnsList ?? this.quesAnsList,
      quesAnsLoadStatus: quesAnsLoadStatus ?? this.quesAnsLoadStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      emailId,
      password,
      signUpStatus,
      loginStatus,
      token,
      ballDirection,
      currentQuestion,
      changeQuestionStatus,
      quesAnsList,
      quesAnsLoadStatus,
    ];
  }
}
