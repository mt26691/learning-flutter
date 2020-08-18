import 'package:flutter/material.dart';
import './answer.dart';
import './question.dart';

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

  final questions = [
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
        body: _questionIndex < questions.length
            ? Column(
                children: [
                  Question(questions[_questionIndex]['questionText']),
                  ...(questions[_questionIndex]['answers'] as List<String>)
                      .map((answer) => Answer(
                            selectHandler: _answerQuestion,
                            answerText: answer,
                          ))
                      .toList()
                ],
              )
            : Center(
                child: Text('You did it!'),
              ),
      ),
    );
  }
}
