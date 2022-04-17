import 'package:app_learn_english/resources/vocabulary_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/vocabulary_model.dart';

part '../events/list_vocabulary_event.dart';

part '../states/list_vocabulary_state.dart';

class ListVocabularyBloc
    extends Bloc<ListVocabularyEvent, ListVocabularyState> {
  List<VocabularyModel> listVoca = [];

  ListVocabularyBloc() : super(ListVocabularyLoadingState()) {
    on<ListVocabularyEventLoad>((event, emit) async {
      emit(ListVocabularyLoadingState());
      try {
        final listVocatopic =
            await VocabularyService.getAllVocabularyTopic(event.idTopic);
        listVoca = listVocatopic;
        emit(ListVocabularyLoadedState(listVocatopic));
      } catch (e) {
        emit(ListVocabularyErrorState(e.toString()));
      }
    });
    on<ListVocabularyEventSearch>((event, emit) {
      try {
        if (state is ListVocabularyLoadedState) {
          List<VocabularyModel> listResultSearch = [];
          if (event.searchVocabulary.trim().isEmpty) {
            emit(ListVocabularyLoadedState(listVoca));
          } else {
            emit(ListVocabularyLoadingState());
            for (var voca in listVoca) {
              if (voca.content.contains(event.searchVocabulary) ||
                  voca.mean.contains(event.searchVocabulary)) {
                listResultSearch.add(voca);
              }
            }
            emit(ListVocabularyLoadedState(listResultSearch));
          }
        }
      } catch (e) {
        emit(ListVocabularyErrorState(e.toString()));
      }
    });
  }
}
