import 'package:app_learn_english/models/topic_vocabulary_model.dart';

class TopicVocabularyState {

  final List<TopicVocabulary> listTopics;

  const TopicVocabularyState(this.listTopics);

  List<Object> get props => [listTopics];

}