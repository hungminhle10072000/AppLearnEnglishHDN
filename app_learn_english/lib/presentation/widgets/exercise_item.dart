import 'package:app_learn_english/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseItem({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'topicVocabulary');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: exercise.image,
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(exercise.name),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
