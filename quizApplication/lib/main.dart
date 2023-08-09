import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'The Battle of Plassey was fought in?',
      'answers': ['1757', '1782', '1748', '1764'],
      'correctIndex': 0,
    },
    {
      'question': 'A train 125 m long passes a man, running at 5 km/hr in the same direction in which the train is going, in 10 seconds. The speed of the train is:',
      'answers': ['45km/h', '50km/h', '54km/h', '55km/h'],
      'correctIndex': 1,
    },
    {
      'question': 'In which decade was the American Institute of Electrical Engineers (AIEE) founded?',
      'answers': ['1850s', '1880s', '1930s', '1950s'],
      'correctIndex': 1,
    },
    {
      'question': '20th August is celebrated as?',
      'answers': ['Earth Day', 'Sadbhavana Divas', 'No Tobacco Day', 'None Of These'],
      'correctIndex': 1,
    },
    {
      'question': 'Ordinary table salt is sodium chloride. What is baking soda?',
      'answers': ['Potassium Chloride', 'Potassium Carbonate', 'Potassium Hydroxide', 'Sodium Bicarbonate'],
      'correctIndex': 3,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    int correctIndex = _questions[_questionIndex]['correctIndex'];
    if (selectedIndex == correctIndex) {
      setState(() {
        _score++;
      });
    }
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: $_score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _questionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _questions[_questionIndex]['question'],
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: (_questions[_questionIndex]['answers'] as List<String>).map(
                    (answer) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        // side: BorderSide(color: Colors.yellow, width: 5),
                        textStyle: const TextStyle(
                            color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),

                      onPressed: () {
                        _answerQuestion(
                            (_questions[_questionIndex]['answers'] as List<String>).indexOf(answer));
                      },
                      child: Text(answer),
                    ),
                  );
                },
              ).toList(),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Question ${_questionIndex + 1}/${_questions.length}'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                // side: BorderSide(color: Colors.yellow, width: 5),
                textStyle: const TextStyle(
                    color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                _showResultDialog();
              },
              child: Text('End Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
