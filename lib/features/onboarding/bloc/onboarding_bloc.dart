import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindpeers_intro/features/core/constants/enums.dart';
import 'package:mindpeers_intro/features/core/event_transformers/debounce_restartable.dart';
import 'package:mindpeers_intro/features/core/event_transformers/throttle_droppable.dart';
import 'package:mindpeers_intro/features/core/status/status.dart';
import 'package:mindpeers_intro/features/onboarding/models/ques_ans_model.dart';
import 'package:mindpeers_intro/features/onboarding/repository/onboarding_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(
    this._remoteRepository,
  ) : super(const OnboardingState()) {
    on<SetEmailId>(
      _onSetEmailId,
      transformer: debounceRestartable(),
    );
    on<SetPassword>(
      _onSetPassword,
      transformer: debounceRestartable(),
    );
    on<LogIn>(
      _onLogIn,
      transformer: throttleDroppable(),
    );
    on<SignUp>(
      _onSignUp,
      transformer: throttleDroppable(),
    );
    on<SetQuestion>(
      _onSetQuestion,
    );
  }

  final IOnboardingRepository _remoteRepository;

  void _onSetEmailId(
    SetEmailId event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        emailId: event.emailId,
      ),
    );
  }

  void _onSetPassword(
    SetPassword event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<void> _onLogIn(
    LogIn event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        loginStatus: const Status.loading(),
      ),
    );

    await Future.delayed(const Duration(seconds: 2), () {});

    final faiilureOrSuccess = await _remoteRepository.login(
      email: state.emailId,
      password: state.password,
    );

    emit(
      faiilureOrSuccess.fold(
        (f) => state.copyWith(
          loginStatus: Status.failure(f),
        ),
        (quesAnsList) => state.copyWith(
          loginStatus: const Status.success(),
        ),
      ),
    );
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        signUpStatus: const Status.loading(),
      ),
    );

    await Future.delayed(const Duration(seconds: 2), () {});

    final failureOrQuesAnsList = await _remoteRepository.register(
      email: state.emailId,
      password: state.password,
    );

    emit(
      failureOrQuesAnsList.fold(
        (f) => state.copyWith(
          signUpStatus: Status.failure(f),
        ),
        (quesAnsList) => state.copyWith(
          signUpStatus: const Status.success(),
          quesAnsList: quesAnsList,
        ),
      ),
    );
  }

  Future<void> _onSetQuestion(
    SetQuestion event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        changeQuestionStatus: const Status.loading(),
        ballDirection: BallDirection.none,
      ),
    );

    var quesAnsModel = state.quesAnsList[state.currentQuestion];

    quesAnsModel = quesAnsModel.copyWith(
      selectedAnsIndex: event.selectedAnsIndex,
    );

    final list = List.of(state.quesAnsList)
      ..removeAt(state.currentQuestion)
      ..insert(state.currentQuestion, quesAnsModel);

    emit(
      state.copyWith(
        quesAnsList: list,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 200), () {});

    final newQuesIndex = event.ballDirection == BallDirection.forward
        ? state.currentQuestion + 1
        : state.currentQuestion - 1 < 0
            ? state.currentQuestion
            : state.currentQuestion - 1;

    emit(
      state.copyWith(
        currentQuestion: newQuesIndex,
        ballDirection: (event.ballDirection == BallDirection.forward &&
                    state.currentQuestion == state.quesAnsList.length) ||
                (event.ballDirection == BallDirection.backward &&
                    state.currentQuestion - 1 < 0)
            ? BallDirection.none
            : event.ballDirection,
        changeQuestionStatus: const Status.success(),
      ),
    );
  }
}
