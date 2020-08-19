import 'package:flutter/material.dart';
import 'package:learn_flutter/quiz.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    print('------');
    _totalScore += score;
    print(_totalScore);
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  final _questions = [
    {
      'questionText': 'What is your name',
      'answers': [
        {'text': 'Tung', 'score': 10},
        {'text': 'Bim', 'score': 9},
        {'text': 'Ty', 'score': 8},
      ],
    },
    {
      'questionText': 'where are you from',
      'answers': [
        {'text': 'VietNam', 'score': 10},
        {'text': 'DaNang', 'score': 9},
      ],
    },
    {
      'questionText': 'What is your favorite color',
      'answers': [
        {'text': 'Red', 'score': 10},
        {'text': 'Black', 'score': 9},
        {'text': 'Blue', 'score': 8},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(
                resultScore: _totalScore,
              ),
      ),
    );
  }
}
