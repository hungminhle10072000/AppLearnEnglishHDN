part of '../blocs/list_grammar_bloc.dart';

@immutable
abstract class ListGrammarEvent extends Equatable {
  const ListGrammarEvent();
}

class ListGrammarEventLoad extends ListGrammarEvent {
  const ListGrammarEventLoad();

  @override
  List<Object> get props => [];
}

class ListGrammarEventSearch extends ListGrammarEvent {
  final String searchGrammar;

  const ListGrammarEventSearch(this.searchGrammar);

  @override
  List<Object> get props => [searchGrammar];
}
