import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function restartQuiz;
  Result({
    this.resultScore,
    this.restartQuiz,
  });

  String get resultPhrase {
    return 'Your score = ' + resultScore.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text('Restart Quiz'), onPressed: restartQuiz)
        ],
      ),
    );
  }
}
