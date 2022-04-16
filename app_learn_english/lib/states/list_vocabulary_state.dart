part of '../blocs/list_vocabulary_bloc.dart';

@immutable
abstract class ListVocabularyState extends Equatable {}

class ListVocabularyLoadingState extends ListVocabularyState {

  @override
  List<Object?> get props => [];
}

class ListVocabularyLoadedState extends ListVocabularyState {

  final List<VocabularyModel> listVocabularies;

  ListVocabularyLoadedState(this.listVocabularies);

  @override
  List<Object> get props => [listVocabularies];

}

class ListVocabularyErrorState extends ListVocabularyState {

  final String error;

  ListVocabularyErrorState(this.error);

  @override
  List<Object?> get props => [error];

}
