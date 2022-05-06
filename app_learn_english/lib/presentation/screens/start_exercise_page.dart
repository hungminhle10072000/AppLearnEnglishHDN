import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/presentation/screens/questions_exercise_page.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/material.dart';

class StartExercisePage extends StatelessWidget {
  final ExerciseModel exercise;
  const StartExercisePage({Key? key, required this.exercise}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      Navigator.pushNamed(context, '/listExercise');
      return true;
    }
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: const Text("Multiple Choice Quiz"),
        backgroundColor: Colors.blueAccent,
        leading: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/listExercise');
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const Text("Bắt đầu làm bài",
                style: TextStyle(
                  fontSize: fontSize.large, fontWeight: FontWeight.bold,
                ),),
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child:  const Text("Chúc bạn may mắn",
                style: TextStyle(
                  fontSize: fontSize.medium,
                ),),
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50.0,
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuestionsExercisePage(exercise: exercise))
                );
              },
              child:  const Text("Bắt đầu", style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
              ),),
            )
          ],
        ),
      ),
    ), onWillPop: _onBackPressed);
  }


}
