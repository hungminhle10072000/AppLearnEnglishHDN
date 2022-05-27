import 'dart:async';

import 'package:app_learn_english/blocs/list_vocabulary_bloc.dart';
import 'package:app_learn_english/resources/vocabulary_service.dart';
import 'package:app_learn_english/states/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/vocabulary_model.dart';

class PracticeVocabularyPage extends StatefulWidget {
  const PracticeVocabularyPage({Key? key}) : super(key: key);

  @override
  State<PracticeVocabularyPage> createState() => _PracticeVocabularyPageState();
}

class _PracticeVocabularyPageState extends State<PracticeVocabularyPage> {
  List<VocabularyModel> listQuestionVoca = [];
  Map<String, String> mapResult = new Map();
  int indexQuestion = 0;
  int indexColor = 0;
  bool checkDisplay = false;
  bool _checkCreateMapAnswer = false;
  AudioPlayer audioPlayer = AudioPlayer();
  TextEditingController answerController = TextEditingController();
  List<Color> squareColors = [Colors.grey.shade100, Colors.green, Colors.red];
  bool checkOpenSuggest = false;
  dynamic userId;

  void _countCorrectAnswer() async {
    int count = 0;
    this.mapResult.forEach((key, value) {
      String keyCheck = key.toString().trim();
      String valueCheck = value.toString().trim();
      if (keyCheck == valueCheck) {
        count++;
      }
    });
    dynamic userId = CurrentUserState.id;
    var response = await VocabularyService.writeScore(count, userId);
    if (response.statusCode == 200) {
      Alert(
          closeFunction: () {
            Navigator.pushNamed(context, '/listExercise');
          },
          context: context,
          title: "Kết quả: ${count}/${listQuestionVoca.length}",
          desc: "Bạn đã đạt được ${count * 10} điểm !!!",
          image: Image.asset("assets/images/success.png"),
          buttons: []).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Kết quả: ${count}/${listQuestionVoca.length}",
        desc: "Ghi điểm thất bại!!! \n Xin hãy thử lại",
        buttons: [],
      ).show();
      // throw Exception(response.errors);
    }
  }

  void _incrementQuestion() {
    if (!checkOpenSuggest) {
      String answerSubmit = answerController.text;
      this.mapResult[listQuestionVoca[indexQuestion].content.trim()] =
          answerSubmit;
      if (indexQuestion < listQuestionVoca.length - 1) {
        setState(() {
          indexQuestion++;
          indexColor = 0;
          // answerController.clear();
        });
      }
      if (indexQuestion == listQuestionVoca.length - 1) {
        setState(() {
          checkDisplay = true;
        });
      }
      answerController.text =
          mapResult[listQuestionVoca[indexQuestion].content.trim()].toString();
    }
  }

  void _decrementQuestion() {
    if (!checkOpenSuggest) {
      String answerSubmit = answerController.text;
      this.mapResult[listQuestionVoca[indexQuestion].content.trim()] =
          answerSubmit;
      if (indexQuestion > 0) {
        setState(() {
          indexQuestion--;
          indexColor = 0;
          // answerController.clear();
        });
      }
      if (indexQuestion < listQuestionVoca.length - 1) {
        setState(() {
          checkDisplay = false;
        });
      }
      answerController.text =
          mapResult[listQuestionVoca[indexQuestion].content.trim()].toString();
    }
  }

  void _suggestAnswer() {
    var duration = Duration(seconds: 3);
    setState(() {
      answerController.text = this.listQuestionVoca[indexQuestion].content;
      checkOpenSuggest = true;
    });
    Timer(duration, _closeSuggetAnswer);
  }

  void _closeSuggetAnswer() {
    setState(() {
      answerController.clear();
      checkOpenSuggest = false;
    });
  }

  createResult(List<VocabularyModel> listVoca) {
    if (!_checkCreateMapAnswer) {
      _checkCreateMapAnswer = true;
      listQuestionVoca = listVoca;
      if (listVoca.length > 0) {
        for (int i = 0; i < listVoca.length; i++) {
          this.mapResult[listVoca[i].content.trim()] = "";
        }
        ;
      }
    }
  }

  void _checkAnswer() {
    String answerSubmit = answerController.text;
    this.mapResult[listQuestionVoca[indexQuestion].content.trim()] =
        answerSubmit;
    String corectAnswer =
        listQuestionVoca[indexQuestion].content.toString().trim();
    String answer = answerSubmit.toString().trim();
    if (corectAnswer == answer) {
      setState(() {
        indexColor = 1;
      });
    } else {
      setState(() {
        indexColor = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Luyện tập",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        body: BlocBuilder<ListVocabularyBloc, ListVocabularyState>(
          builder: (context, state) {
            if (state is ListVocabularyLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ListVocabularyLoadedState) {
              createResult(state.listVocabularies);
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Câu:${indexQuestion + 1}/${this.listQuestionVoca.length}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image: this.listQuestionVoca[indexQuestion].image,
                              width: 150,
                              height: 150,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await audioPlayer.play(this
                                  .listQuestionVoca[indexQuestion]
                                  .file_audio);
                            },
                            child: Icon(
                              Icons.volume_down_outlined,
                              color: Colors.lightBlue,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giải thích : ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.red),
                          ),
                          Expanded(
                              child: Text(this
                                  .listQuestionVoca[indexQuestion]
                                  .explain_vocabulary))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Từ loại : ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.red),
                          ),
                          Expanded(
                              child: Text(
                                  this.listQuestionVoca[indexQuestion].mean))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 0.75 * MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextFormField(
                          controller: answerController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Yêu cầu nhập đáp án';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Nhập đáp án',
                            fillColor: squareColors[this.indexColor],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton(
                            onPressed: _decrementQuestion,
                            child: Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white54,
                          ),
                          ElevatedButton(
                              onPressed: _suggestAnswer, child: Text("Gợi ý")),
                          ElevatedButton(
                              onPressed: checkOpenSuggest ? null : _checkAnswer,
                              child: Text("kiểm tra")),
                          FloatingActionButton(
                            onPressed: _incrementQuestion,
                            child: Icon(
                              Icons.skip_next,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white54,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        child: ElevatedButton(
                            onPressed: _countCorrectAnswer,
                            child: Text("Ghi điểm")),
                        visible: checkDisplay,
                      ),
                    ],
                  ),
                ),
              ); // return VocabularyListWidget(state.listVocabularies);
            }
            if (state is ListVocabularyErrorState) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Container();
          },
        ));
  }
}
