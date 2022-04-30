import 'package:app_learn_english/blocs/exercise_bloc.dart';
import 'package:app_learn_english/states/exercise_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseListPage extends StatelessWidget {
  const ExerciseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ExercisePage");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Luyện tập"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Danh Sách Bài Tập", style: TextStyle(fontSize: fontSize.large, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ExerciseBloc, ExerciseState>(
                builder: (context, state) {
                  return Text("Success");
                }
            ),
            new Expanded(
                child: GridView.count(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'topicVocabulary');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: Image(
                                image: AssetImage('assets/images/vocabulary.jpg'),
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                                height: 128,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Từ vựng'
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
