import 'package:app_learn_english/models/vocabulary_model.dart';
import 'package:flutter/material.dart';

class VocabularyWidget extends StatelessWidget {
  final VocabularyModel vocabularyModel;

  const VocabularyWidget({Key? key, required this.vocabularyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 140,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    vocabularyModel.content,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  (vocabularyModel.mean.length > 40)
                      ? Text(
                          vocabularyModel.mean.substring(0, 40) + " .....",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(vocabularyModel.mean,
                          style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Icon(
                Icons.add,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
