import 'package:app_learn_english/resources/vocabulary_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/vocabulary_model.dart';

part '../events/list_vocabulary_event.dart';

part '../states/list_vocabulary_state.dart';

class ListVocabularyBloc
    extends Bloc<ListVocabularyEvent, ListVocabularyState> {
  ListVocabularyBloc() : super(ListVocabularyLoadingState()) {
    on<ListVocabularyEventLoad>((event, emit) async {
      emit(ListVocabularyLoadingState());
      try {
        final listVocatopic =
            await VocabularyService.getAllVocabularyTopic(event.idTopic);
        emit(ListVocabularyLoadedState(listVocatopic));
      } catch (e) {
        emit(ListVocabularyErrorState(e.toString()));
      }
    });
    on<ListVocabularyEventSearch>((event, emit) {
      // emit(ListVocabularyLoadingState());
      try {
        print((state as ListVocabularyLoadedState).listVocabularies);
        // List<VocabularyModel> listResultSearch = [];

      } catch (e) {
        emit(ListVocabularyErrorState(e.toString()));
      }
    });
  }
}
