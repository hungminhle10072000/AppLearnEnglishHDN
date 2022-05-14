import 'package:app_learn_english/blocs/exercise_bloc.dart';
import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/presentation/widgets/exercise_item_list.dart';
import 'package:app_learn_english/states/exercise_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/StringRenderUtil.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExerciseListPage();
  }
}

class _ExerciseListPage extends State<ExerciseListPage> {
  bool isSearching = false;
  final searchController = TextEditingController();
  late String keyword = '';

  var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 16,
      color: Color.fromRGBO(63, 63, 63, 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: !isSearching
            ? TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ))
            : null,
        title: !isSearching
            ? const Text(
                "Bài tập",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              )
            : TextField(
                controller: searchController,
                onChanged: (text) {
                  setState(() {
                    keyword = text;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: GestureDetector(
                      onTap: () {
                        print('OnTap 1');
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Tìm kiếm..."),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                      setState(() {
                        keyword = '';
                      });
                      searchController.clear();
                    });
                  },
                  icon: const Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Luyện từ vựng",
              style: TextStyle(
                  fontSize: fontSize.large, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'homeTotalPracticeVocabulary');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: 'https://s18670.pcdn.co/wp-content/uploads/GettyImages-502558245-1.jpg',
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 100,
                          ),
                          const Text("Tổng ôn",style: TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: 'https://theidealteacher.com/wp-content/uploads/2018/11/Excellent-Vocabulary-Practice-Ideas-for-Language-Lessons-Revision-1.png',
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 100,
                          ),
                          const Text("Luyện theo chủ đề", style: TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Danh Sách Bài Tập",
              style: TextStyle(
                  fontSize: fontSize.large, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
              if (state is ExerciseStateInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ExerciseStateFailure) {
                return const Center(
                  child: Text(
                    'Cannot load exercises from Server',
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                );
              }
              if (state is ExerciseStateSuccess) {
                if (state.exercises.length > 0) {
                  List<ExerciseModel> currentExercises = [];
                  if (keyword.isEmpty) {
                    currentExercises = state.exercises;
                  } else {
                    currentExercises = state.exercises
                        .where((element) =>
                            StringRenderUtil.searching(element.name, keyword))
                        .toList();
                  }
                  if (currentExercises.length < 1) {
                    return const Center(
                      child: Text(
                        'Không tìm thấy kết quả!',
                        style: TextStyle(
                            fontSize: fontSize.medium, color: Colors.redAccent),
                      ),
                    );
                  }
                  // return ExerciseItem(exercise: currentExercises[0]);
                  return ExerciseItemList(exercises: currentExercises);
                }
              }
              return const Text("");
            }),
          ],
        ),
      ),
    );
  }
}
