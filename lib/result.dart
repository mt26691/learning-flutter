import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;

  Result({
    this.resultScore,
  });

  String get resultPhrase {
    return 'Your score = ' + resultScore.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        resultPhrase,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
