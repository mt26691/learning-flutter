import 'package:flutter/material.dart';
import 'package:learn_flutter/question-result.dart';
import 'package:learn_flutter/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final questions = [
    {
      'questionText': 'what is your name?',
      'answers': [
        {'text': 'Tung', 'score': 1.0},
        {'text': 'Bim', 'score': 2.0},
      ]
    },
    {
      'questionText': 'what is your pet name?',
      'answers': [
        {'text': 'Tung', 'score': 3.0},
        {'text': 'Bim', 'score': 4.0},
      ]
    }
  ];

  var _questionIndex = 0;
  var totalScore = 0.0;

  void _answerQuestion(double score) {
    if (_questionIndex <= questions.length) {}
    this.totalScore += score;

    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
  }

  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      totalScore = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz app'),
          ),
          body: _questionIndex < questions.length
              ? Quiz(
                  questions: questions,
                  questionIndex: _questionIndex,
                  answerQuestion: this._answerQuestion)
              : QuestionResult(this.totalScore, this.resetQuiz),
        ));
  }
}
