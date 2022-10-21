import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mindpeers_intro/features/core/datasources/decoders.dart';
import 'package:mindpeers_intro/features/core/datasources/failures/failures.dart';
import 'package:mindpeers_intro/features/core/datasources/services/api_service/api_client.dart';
import 'package:mindpeers_intro/features/core/datasources/services/api_service/endpoints.dart';
import 'package:mindpeers_intro/features/onboarding/models/ques_ans_model.dart';

abstract class IOnboardingRepository {
  Future<Either<Failure, List<QuesAnsModel>>> register({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
}

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository extends IOnboardingRepository {
  @override
  Future<Either<Failure, List<QuesAnsModel>>> register({
    required String email,
    required String password,
  }) async {
    try {
      // await ApiClient.post(
      //   Endpoints.regitser,
      //   body: json.encode({
      //     'email': email,
      //     'password': password,
      //   }),
      // );

      final jsonString =
          await rootBundle.loadString('assets/json/user_health_ques.json');

      final data = await Decoders.decodeQuesAndAnsList(jsonString);

      return right(data);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    try {
      // await ApiClient.post(
      //   Endpoints.login,
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      // );

      return right(unit);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
