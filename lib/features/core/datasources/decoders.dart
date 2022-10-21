import 'dart:convert';

import 'package:mindpeers_intro/features/core/datasources/failures/failures.dart';
import 'package:mindpeers_intro/features/onboarding/models/ques_ans_model.dart';

class Decoders {
  Decoders._();

  static Future<List<QuesAnsModel>> decodeQuesAndAnsList(String json) async {
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;

      return (map['data'] as List)
          .map(
            (e) => QuesAnsModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Failure.value(e.toString());
    }
  }
}
