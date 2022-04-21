part of '../blocs/list_grammar_bloc.dart';

@immutable
abstract class ListGrammarState extends Equatable {}

class ListGrammarLoadingState extends ListGrammarState {
  @override
  List<Object> get props => [];
}

class ListGrammarLoadedState extends ListGrammarState {
  final List<GrammarModel> listGrammar;

  ListGrammarLoadedState(this.listGrammar);

  @override
  List<Object> get props => [listGrammar];
}

class ListGrammarErrorState extends ListGrammarState {
  final String error;

  ListGrammarErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
