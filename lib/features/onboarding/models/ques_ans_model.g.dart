// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ques_ans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuesAnsModel _$QuesAnsModelFromJson(Map<String, dynamic> json) => QuesAnsModel(
      question: json['ques'] as String,
      answers: (json['ans'] as List<dynamic>).map((e) => e as String).toList(),
      selectedAnsIndex: json['selectedAnsIndex'] as int? ?? -1,
    );

Map<String, dynamic> _$QuesAnsModelToJson(QuesAnsModel instance) =>
    <String, dynamic>{
      'ques': instance.question,
      'ans': instance.answers,
      'selectedAnsIndex': instance.selectedAnsIndex,
    };
