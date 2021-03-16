import 'dart:html';

import 'package:flutter/material.dart';

class QuestionResult extends StatelessWidget {
  final double finalScore;
  final Function reset;

  QuestionResult(this.finalScore, this.reset);

  String get resultPhrase {
    return "You did it " + finalScore.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: reset,
            child: Text('Restart Quiz'),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue)),
          )
        ],
      ),
    );
  }
}
