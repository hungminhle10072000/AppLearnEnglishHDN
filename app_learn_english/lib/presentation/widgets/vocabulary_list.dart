import 'package:app_learn_english/models/vocabulary_model.dart';
import 'package:app_learn_english/presentation/widgets/vocabulary.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VocabularyListWidget extends StatelessWidget {
  final List<VocabularyModel> listVocabularyTopic;
  final AudioPlayer audioPlayer = AudioPlayer();

  VocabularyListWidget(this.listVocabularyTopic);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: ListView.builder(
          itemCount: listVocabularyTopic.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child:
                  VocabularyWidget(vocabularyModel: listVocabularyTopic[index]),
              onTap: () {
                showDialogFunc(context, listVocabularyTopic[index]);
              },
            );
          }),
    );
  }

  showDialogFunc(BuildContext context, VocabularyModel voca) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await audioPlayer.play(voca.file_audio);
                          },
                          child: Icon(
                            Icons.volume_down_outlined,
                            color: Colors.lightBlue,
                            size: 50,
                          ),
                        ),
                        Text(
                          voca.content,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      voca.image,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text.rich(
                        TextSpan(children: <InlineSpan>[
                          TextSpan(
                              text: voca.explain_vocabulary,
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ], text: 'Giải thích: '),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                        TextSpan(children: <InlineSpan>[
                          TextSpan(
                              text: voca.mean,
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ], text: 'Từ loại: '),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                        TextSpan(children: <InlineSpan>[
                          TextSpan(
                              text: voca.example_vocabulary,
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ], text: 'Ví dụ: '),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(TextSpan(text: voca.mean_example_vocabulary),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
