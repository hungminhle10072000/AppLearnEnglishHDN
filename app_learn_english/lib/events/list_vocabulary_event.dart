part of '../blocs/list_vocabulary_bloc.dart';

@immutable
abstract class ListVocabularyEvent extends Equatable {
  const ListVocabularyEvent();
}

class ListVocabularyEventLoad extends ListVocabularyEvent {

  final int idTopic;

  const ListVocabularyEventLoad(this.idTopic);

  @override
  List<Object> get props => [idTopic];

}

class ListVocabularyEventSearch extends ListVocabularyEvent {

  final String searchVocabulary;

  const ListVocabularyEventSearch(this.searchVocabulary);

  @override
  List<Object> get props => [searchVocabulary];

}
