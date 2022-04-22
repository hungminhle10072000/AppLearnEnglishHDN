import 'package:app_learn_english/models/grammar_model.dart';
import 'package:app_learn_english/resources/grammar_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part '../events/list_grammar_event.dart';

part '../states/list_grammar_state.dart';

class ListGrammarBloc extends Bloc<ListGrammarEvent, ListGrammarState> {
  List<GrammarModel> listGrammar = [];

  ListGrammarBloc() : super(ListGrammarLoadingState()) {
    on<ListGrammarEventLoad>((event, emit) async {
      emit(ListGrammarLoadingState());
      try {
        final listGrammarLoad = await GrammarService.getAllGrammar();
        listGrammar = listGrammarLoad;
        print(listGrammarLoad);
        emit(ListGrammarLoadedState(listGrammarLoad));
      } catch (e) {
        emit(ListGrammarErrorState(e.toString()));
      }
    });
  }
}
