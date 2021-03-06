import 'package:app_learn_english/events/result_detail_event.dart';
import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/models/result_model.dart';
import 'package:app_learn_english/presentation/screens/start_exercise_page.dart';
import 'package:app_learn_english/states/current_user_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/result_detail_bloc.dart';
import '../screens/end_exercise_page.dart';

class ExerciseItem extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseItem({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDone;
    if (exercise.resultEntityList.isNotEmpty) {
      ResultModel resultModel = exercise.resultEntityList.firstWhere((element) => element.userId == CurrentUserState.id,
          orElse: () => ResultModel(totalRight: 0, id: -1, userId: -1, totalWrong: 0, correctListen: '', correctRead: ''));
      if (resultModel.id == -1 && resultModel.userId == -1) {
        isDone = false;
      } else {
        isDone = resultModel.totalWrong + resultModel.totalRight > 0;
      }
    } else {
      isDone = false;
    }

    return GestureDetector(
      onTap: () {
        !isDone ?
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StartExercisePage(exercise: exercise))
        ) :
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                BlocProvider(create: (context) {
                  final _resultDetailBloc = ResultDetailBloc();
                  final _resultDetailEvent = ResultDetailFetchEvent(userId: CurrentUserState.id,exerciseId: exercise.id);
                  _resultDetailBloc.add(_resultDetailEvent);
                  return _resultDetailBloc;
                },
                  child: EndExercisePage(resultDetail: [],exerciseModel: exercise,),
                )
            )
        );
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
            isDone ? const Text("???? ho??n th??nh", style: TextStyle(
              color: Colors.amber,
              fontSize: fontSize.medium
            ),) : const Text("Ch??a l??m" , style: TextStyle(
              color: Colors.green,
              fontSize: fontSize.medium
            ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
