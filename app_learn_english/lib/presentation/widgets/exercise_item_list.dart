import 'package:app_learn_english/models/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exercise_item.dart';

class ExerciseItemList extends StatelessWidget {
  final List<ExerciseModel> exercises;
  const ExerciseItemList({required this.exercises});
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: GridView.count(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              crossAxisCount: 2,
              children: exercises.map((exercise) => ExerciseItem(exercise:exercise)).toList()
          ));
  }
}
