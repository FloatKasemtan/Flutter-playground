import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    return 'You got ' + resultScore.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Nice job!'),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.brown),
            onPressed: resetHandler,
            child: Text(
              'Restart the quiz!',
            ),
          )
        ],
      ),
    );
  }
}
