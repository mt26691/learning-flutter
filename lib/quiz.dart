import 'package:flutter/material.dart';
import 'package:learn_flutter/answer.dart';
import 'package:learn_flutter/questions.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final List<Map<String, Object>> questions;
  final int questionIndex;
  Quiz(
      {@required this.answerQuestion,
      @required this.questions,
      @required this.questionIndex});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map(
                (e) => Answer(() => this.answerQuestion(e['score']), e['text']))
            .toList()
      ],
    );
  }
}
