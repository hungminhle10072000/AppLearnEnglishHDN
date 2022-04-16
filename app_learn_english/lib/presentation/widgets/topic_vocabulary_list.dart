import 'package:app_learn_english/blocs/list_vocabulary_bloc.dart';
import 'package:app_learn_english/presentation/widgets/topic_vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/list_vocabulary_bloc.dart';
import '../../models/topic_vocabulary_model.dart';

class topic_vocabulary_list extends StatelessWidget {
  final List<TopicVocabulary> topics;

  topic_vocabulary_list(this.topics);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: topic_vocabulary(topics[index]),
              onTap: () {
                context
                    .read<ListVocabularyBloc>()
                    .add(ListVocabularyEventLoad(topics[index].id));
                Navigator.pushNamed(context, 'listVocaTopic');
              },
            );
          }),
    );
  }
}
