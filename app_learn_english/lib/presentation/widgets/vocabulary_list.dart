import 'package:app_learn_english/models/vocabulary_model.dart';
import 'package:app_learn_english/presentation/widgets/vocabulary.dart';
import 'package:flutter/material.dart';

class VocabularyListWidget extends StatelessWidget {
  final List<VocabularyModel> listVocabularyTopic;

  VocabularyListWidget(this.listVocabularyTopic);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: ListView.builder(
          itemCount: listVocabularyTopic.length,
          itemBuilder: (context, index){
            return GestureDetector(
              child: VocabularyWidget(vocabularyModel: listVocabularyTopic[index]),
              onTap: () {},
            );
          }),
    );
  }
}
