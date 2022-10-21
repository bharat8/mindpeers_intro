// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ques_ans_model.g.dart';

class QuesAnsModelField {
  QuesAnsModelField._();

  static const ques = 'ques';
  static const ans = 'ans';
}

@JsonSerializable()
class QuesAnsModel extends Equatable {
  const QuesAnsModel({
    required this.question,
    required this.answers,
    this.selectedAnsIndex = -1,
  });

  factory QuesAnsModel.fromJson(Map<String, dynamic> json) =>
      _$QuesAnsModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuesAnsModelToJson(this);

  @JsonKey(name: QuesAnsModelField.ques)
  final String question;

  @JsonKey(name: QuesAnsModelField.ans)
  final List<String> answers;

  final int selectedAnsIndex;

  @override
  List<Object> get props => [question, answers, selectedAnsIndex];

  QuesAnsModel copyWith({
    String? question,
    List<String>? answers,
    int? selectedAnsIndex,
  }) {
    return QuesAnsModel(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      selectedAnsIndex: selectedAnsIndex ?? this.selectedAnsIndex,
    );
  }
}
