import 'dart:ffi';

import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _user_score = 0;
  final _questions = const [
    {
      'questionText': 'What\'s your favourite color?',
      'answers': [
        {'text': 'Red', 'score': 10},
        {'text': 'Green', 'score': 5},
        {'text': 'Blue', 'score': 6},
      ]
    },
    {
      'questionText': 'What\'s your favourite animal?',
      'answers': [
        {'text': 'Red panda', 'score': 10},
        {'text': 'Rabbit', 'score': 5},
        {'text': 'Blue Whale', 'score': 7},
        {'text': 'Lion', 'score': 6}
      ]
    },
  ];

  void _answerQuestion(int score) {
    _user_score += score;
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
    if (_questionIndex >= _questions.length - 1) {
      print('Quiz done!');
    }
    print(_user_score);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _user_score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My First App'),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  questions: _questions,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex)
              : Result(_user_score, _resetQuiz)),
    );
  }
}
