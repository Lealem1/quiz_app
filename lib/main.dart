import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 133, 4, 173),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/quiz.png',
             width: 500,
             height: 450,
            ),
            const Text(
              'Wellcome to Quiz App!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 11, 8, 9)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizApp()),
                );
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizAppState createState() => _QuizAppState();
}

 class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  int _score = 0;
  bool _showCorrectAnswer = false;
  
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is Flutter?',
      'answers': [
        {'text': 'A programming language', 'score': 0},
        {'text': 'A mobile development framework', 'score': 1},
        {'text': 'An operating system', 'score': 0},
        {'text': 'A database management system', 'score': 0},
      ],
    },
    {
      'questionText': 'Which programming language is used in Flutter?',
      'answers': [
        {'text': 'Java', 'score': 0},
        {'text': 'C#', 'score': 0},
        {'text': 'Swift', 'score': 0},
        {'text': 'Dart', 'score': 1},
      ],
    },
    {
      'questionText': 'What is the main advantage of using Flutter for mobile app development?',
      'answers': [
        {'text': 'Native performance', 'score': 1},
        {'text': 'Large community support', 'score': 0},
        {'text': 'Easy integration with backend services', 'score': 0},
        {'text': 'Built-in machine learning capabilities', 'score': 0},
      ],
    },
    {
      'questionText': 'Which widget is the base class for all widgets in Flutter?',
      'answers': [
        {'text': 'StatefulWidget', 'score': 0},
        {'text': 'Container', 'score': 0},
        {'text': 'Scaffold', 'score': 0},
        {'text': 'Widget', 'score': 1},
      ],
    },
    {
      'questionText': 'What is Flutter\'s hot reload feature used for?',
      'answers': [
        {'text': 'Optimizing app performance', 'score': 0},
        {'text': 'Adding new features to the app', 'score': 0},
        {'text': 'Debugging and fixing runtime errors', 'score': 1},
        {'text': 'Generating code documentation', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex++;
      _showCorrectAnswer = false;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _showCorrectAnswer = false;
    });
  }

   @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
  
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Quiz App'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 121, 13, 141),
          ),
          child: Center(
            child: Center(
              child: _questionIndex < _questions.length
                  ? Quiz(
                      questionIndex: _questionIndex,
                      questions: _questions,
                      answerQuestion: _answerQuestion,
                      showCorrectAnswer: _showCorrectAnswer,
                    )
                  : Result(
                      _score,
                      _questions.length,
                      _restartQuiz,
                      _questions,
                      key: UniqueKey(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function(int) answerQuestion;
  final bool showCorrectAnswer;

  const Quiz({
    super.key,
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
    required this.showCorrectAnswer,
  });

@override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.purple, // Set the background color to purple
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[questionIndex]['questionText'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            final bool isCorrectAnswer = answer['score'] == 10;
            final bool isSelectedAnswer = showCorrectAnswer && isCorrectAnswer;
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ElevatedButton(
              onPressed: () => answerQuestion(answer['score'] as int),
              style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor:
              isSelectedAnswer ? Colors.green : const Color.fromARGB(255, 23, 4, 56),
                ),
                child: Text(
                  answer['text'] as String,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            );
          // ignore: unnecessary_to_list_in_spreads
          }).toList(),
        ],
      ),
    );
  }
}

class RaisedButton {
  RaisedButton({
    required Text child,
    required Function() onPressed,
    required MaterialColor color,
    required Color textColor, // Add the type annotation for textColor
    Key? key,
  }) {
    // Constructor implementation
  }
}

class Result extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function restartQuiz;
  final List<Map<String, Object>> questions;

  const Result(this.score, this.totalQuestions, this.restartQuiz, this.questions, {required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Quiz Completed!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Score: $score / $totalQuestions',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
         const SizedBox(height: 20),
        const Text(
          'Correct Answers:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: questions.map((question) {
            final String questionText = question['questionText'] as String;
            final List<Map<String, Object>> answers = question['answers'] as List<Map<String, Object>>;
            final int correctAnswerIndex = answers.indexWhere((answer) => answer['score'] == 1);
            final String correctAnswerText = answers[correctAnswerIndex]['text'] as String;


return Column(
              children: [
                Text(
                  questionText,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  ' $correctAnswerText',
                  style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 10),
              ],
            );
          }).toList(),
        ),
     
     const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => restartQuiz(),
          style: ElevatedButton.styleFrom(
            foregroundColor: null,
            backgroundColor: null,
          ),
          child: const Text('Restart Quiz'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Finish'),
        ),
      ],
    );
  }
}