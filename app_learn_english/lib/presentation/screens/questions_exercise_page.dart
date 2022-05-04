import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/models/question_model.dart';
import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:app_learn_english/presentation/screens/end_exercise_page.dart';
import 'package:flutter/material.dart';

var finalScore = 0;

List<ResultDetailModel> yourAnswers = [];

class QuestionsExercisePage extends StatefulWidget {
  final ExerciseModel exercise;
  const QuestionsExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  _QuestionsExercisePageState createState() {
    return _QuestionsExercisePageState();
  }
}

class _QuestionsExercisePageState extends State<QuestionsExercisePage> {
  var questionNumber =0;
  List<QuestionModel> questions = [];
  @override
  void initState() {
    // TODO: implement initState
    questions = widget.exercise.questionEntityList;
    for (int i =0; i< questions.length; i++) {
      yourAnswers.add(
          ResultDetailModel(
              userId: 1,
              questionId: questions[i].id,
              userAnswer: "",
              correctAnswer: questions[i].correctAnswer));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    yourAnswers =[];
  }
  @override
  Widget build(BuildContext context) {
    if (questions.length < 1) {
      return Container(
        child: const Text("Questions is empty"),
      );
    }
    return WillPopScope(
        onWillPop: ()async => false,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Quiz"),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Question ${questionNumber +1} of ${questions.length}",
                            style: const TextStyle(
                                fontSize: 22.0
                            ),),
                          Text("Score $finalScore",
                            style: const TextStyle(
                                fontSize: 22.0
                            ),),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: 'https://web-english.s3.ap-southeast-1.amazonaws.com/1651390256279-avatar.jpg',
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Text('Question ${questionNumber+1}: ${questions[questionNumber].contentQuestion}',
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    const Padding(padding: EdgeInsets.all(20.0)),
                    MaterialButton(
                      onPressed: () {
                        if (questions[questionNumber].option_1 ==
                            questions[questionNumber].correctAnswer) {
                          debugPrint("Correct");
                          finalScore ++;
                        } else {
                          debugPrint("Wrong");
                        }
                        updateQuestion(questionNumber,questions[questionNumber].option_1);
                      },
                      minWidth: 320.0,
                      color: Colors.green,
                      child: Text(questions[questionNumber].option_1,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (questions[questionNumber].option_2 ==
                            questions[questionNumber].correctAnswer) {
                          debugPrint("Correct");
                          finalScore ++;
                        } else {
                          debugPrint("Wrong");
                        }
                        updateQuestion(questionNumber,questions[questionNumber].option_2);
                      },
                      minWidth: 320.0,
                      color: Colors.green,
                      child: Text(questions[questionNumber].option_2,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (questions[questionNumber].option_3 ==
                            questions[questionNumber].correctAnswer) {
                          debugPrint("Correct");
                          finalScore ++;
                        } else {
                          debugPrint("Wrong");
                        }
                        updateQuestion(questionNumber,questions[questionNumber].option_3);
                      },
                      minWidth: 320.0,
                      color: Colors.green,
                      child: Text(questions[questionNumber].option_3,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (questions[questionNumber].option_4 ==
                            questions[questionNumber].correctAnswer) {
                          debugPrint("Correct");
                          finalScore ++;
                        } else {
                          debugPrint("Wrong");
                        }
                        updateQuestion(questionNumber,questions[questionNumber].option_4);
                      },
                      minWidth: 320.0,
                      color: Colors.green,
                      child: Text(questions[questionNumber].option_4,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (questionNumber > 0) {
                                questionNumber --;
                              }
                            });
                          },
                          minWidth: 120.0,
                          color: Colors.green,
                          child: const Text("Prev"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (questionNumber < questions.length-1) {
                                questionNumber ++;
                              }
                            });

                          },
                          minWidth: 120.0,
                          color: Colors.green,
                          child: Text("Next"),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        onPressed: resetQuiz,
                        minWidth: 240.0,
                        height: 30.0,
                        color: Colors.red,
                        child: const Text("Quit",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),),
                      ),
                    ),
                    questions.length - 1 == questionNumber ? Container(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        onPressed: submitHandle,
                        minWidth: 240.0,
                        height: 30.0,
                        color: Colors.blueAccent,
                        child: const Text("Submit",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),),
                      ),
                    ) : Container(

                    )
                  ],
                ),
              ),
            )

          ),
        )
    );
  }
  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      finalScore =0;
      questionNumber = 0;
    });
  }
  void submitHandle() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EndExercisePage(resultDetail: yourAnswers,))
    );
  }
  void updateQuestion(int index, String value) {
    print("A: "+yourAnswers.length.toString());
    yourAnswers[index].userAnswer=value;
    print("UpdateQuestion");
    // setState(() {
    //   if (questionNumber == quiz.question.length -1) {
    //     Navigator.push(context, MaterialPageRoute(
    //         builder: (context) => Summary(score: finalScore) ));
    //   } else {
    //     questionNumber ++;
    //   }
    // });
  }
}
