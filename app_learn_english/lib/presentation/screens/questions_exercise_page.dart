import 'package:app_learn_english/blocs/result_detail_bloc.dart';
import 'package:app_learn_english/events/result_detail_event.dart';
import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/models/question_model.dart';
import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:app_learn_english/presentation/screens/end_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
var finalScore = 0;

List<ResultDetailModel> yourAnswers = [];

class QuestionsExercisePage extends StatefulWidget {
  final ExerciseModel exercise;
  QuestionsExercisePage({Key? key, required this.exercise}) : super(key: key);
  final AudioPlayer audioPlayer = AudioPlayer();
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
              contentQuestion: questions[i].contentQuestion,
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
    bool hasImage = questions[questionNumber].imageDescription.isNotEmpty;
    bool hasAudio = questions[questionNumber].audio.isNotEmpty;
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
                    hasAudio ? GestureDetector(
                      onTap: () async {
                        await widget.audioPlayer.play(questions[questionNumber].audio);
                      },
                      child: const Icon(
                        Icons.volume_down_outlined,
                        color: Colors.lightBlue,
                        size: 50,
                      ),
                    ) : const SizedBox(
                      height: 2,
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    hasImage ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: questions[questionNumber].imageDescription,
                      fit: BoxFit.fitHeight,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ) : const SizedBox(
                      height: 1,
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Text('Question ${questionNumber+1}: ${questions[questionNumber].contentQuestion}',
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    const Padding(padding: EdgeInsets.all(20.0)),
                    questions[questionNumber].option_1.isNotEmpty ?
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
                      color: yourAnswers[questionNumber].userAnswer == questions[questionNumber].option_1  ? Colors.blueAccent : Colors.grey,
                      child: Text(questions[questionNumber].option_1,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ) : const SizedBox(
                      height: 2,
                    ),
                    questions[questionNumber].option_2.isNotEmpty ?
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
                      color: yourAnswers[questionNumber].userAnswer == questions[questionNumber].option_2  ? Colors.blueAccent : Colors.grey,
                      child: Text(questions[questionNumber].option_2,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ) : const SizedBox(
                      height: 2,
                    ),
                    questions[questionNumber].option_3.isNotEmpty ?
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
                      color: yourAnswers[questionNumber].userAnswer == questions[questionNumber].option_3  ? Colors.blueAccent : Colors.grey,
                      child: Text(questions[questionNumber].option_3,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ) : const SizedBox(
                      height: 2,
                    ),
                    questions[questionNumber].option_4.isNotEmpty ?
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
                      color: yourAnswers[questionNumber].userAnswer == questions[questionNumber].option_4  ? Colors.blueAccent : Colors.grey,
                      child: Text(questions[questionNumber].option_4,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white
                        ),),
                    ) : const SizedBox(height: 2,),
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
                          color: Colors.grey,
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
                          color: Colors.grey,
                          child: const Text("Next"),
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
                        child: const Text("Thoát ra",
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

                    ),
                    const SizedBox(
                      height: 15,
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
      Navigator.pop(context);
      finalScore =0;
      questionNumber = 0;
    });
  }
  void submitHandle() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
          BlocProvider(create: (context) {
            final _resultDetailBloc = ResultDetailBloc();
            final _resultDetailEvent = ResultDetailAddEvent(resultDetail: yourAnswers);
            _resultDetailBloc.add(_resultDetailEvent);
            return _resultDetailBloc;
          },
            child: EndExercisePage(resultDetail: yourAnswers,),
          )
        )
    );
  }
  void updateQuestion(int index, String value) {
    print("A: "+yourAnswers.length.toString());
    setState(() {
      yourAnswers[index].userAnswer=value;
    });
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
showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      // esetQuiz  r();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thông báo"),
    content: Text("Bạn có chắc chắn muốn thoát ra không?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
