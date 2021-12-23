import 'dart:convert';

import 'package:bit_flutter/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class QuizHome extends StatefulWidget {
  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  List<Quiz> quizs = [];
  int counter = 0;
  bool loading = true;
  bool isError = false;
  List<String> answers = [];
  bool didUserSelectAnswer = false;

  getQuizData() async {
    try {
      var url = Uri.parse(
          'https://opentdb.com/api.php?amount=19&category=21&difficulty=easy');
      var response = await http.get(url);
      print(response.body);
      jsonDecode(response.body)['results'].forEach((data) {
        quizs.add(Quiz.fromJson(data));
      });
      answers = quizs[0].incorrectAnswers;
      answers.add(quizs[0].correctAnswer);
      answers.shuffle();
      loading = false;
      setState(() {});
    } catch (e) {
      print(e);
      loading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuizData();
  }

  onClickRight() {
    if (counter < (quizs.length - 1)) {
      counter++;
      answers = [];
      answers = quizs[counter].incorrectAnswers;
      answers.add(quizs[counter].correctAnswer);
      answers.shuffle();
      didUserSelectAnswer = false;
      setState(() {});
    }
  }

  onClickLeft() {
    if (counter > 0) {
      counter--;
      answers = [];
      answers = quizs[counter].incorrectAnswers;
      answers.add(quizs[counter].correctAnswer);
      answers.shuffle();
      didUserSelectAnswer = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
        ),
        bottomNavigationBar: isError || loading
            ? SizedBox.shrink()
            : Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        onClickLeft();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade400,
                          ),
                          child: Icon(Icons.arrow_back)),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        onClickRight();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade400,
                          ),
                          child: Icon(Icons.arrow_forward)),
                    )),
                  ],
                ),
              ),
        body: loading
            ? Center(
                child: Lottie.asset('image/loading.json'),
              )
            : isError
                ? Center(
                    child: Column(
                    children: [
                      Lottie.asset('image/error.json'),
                      Text('Something went wrong'),
                    ],
                  ))
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quizs[counter].question,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.green),
                        ),
                      ),
                      ...answers.map((e) => InkWell(
                            onTap: () {
                              didUserSelectAnswer = true;
                              setState(() {});
                              if (e == quizs[counter].correctAnswer) {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.green.shade200,
                                    content: Text(
                                        'Congachulations! Your answer is Correct'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.red.shade200,
                                    content: Text(
                                        'OOPS!!!, You selected wrong ansswer! Correct ansrwer is ${quizs[counter].correctAnswer}'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: e == quizs[counter].correctAnswer
                                      ? didUserSelectAnswer
                                          ? Colors.green.shade400
                                          : Colors.grey.shade400
                                      : didUserSelectAnswer
                                          ? Colors.red.shade400
                                          : Colors.grey.shade400,
                                ),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                )),
                          )),
                    ],
                  ));
  }
}
