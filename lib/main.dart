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

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  final _questions = [
    {
      'questionText': 'What is your name',
      'answers': ['Tung', 'Bim']
    },
    {
      'questionText': 'where are you from',
      'answers': ['Vietnam', 'Da nang']
    },
    {
      'questionText': 'What is your favorite color',
      'answers': ['White', 'Black', 'Asian']
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
            : Result(),
      ),
    );
  }
}
