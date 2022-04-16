import 'dart:async';
import 'package:app_learn_english/blocs/bloc.dart';
import 'package:app_learn_english/events/topic_vocabulary_event.dart';
import 'package:app_learn_english/resources/topic_vocabulary_service.dart';
import '../models/topic_vocabulary_model.dart';
import 'package:rxdart/rxdart.dart';


class TopicVocabularyBloc extends Bloc{

  List<TopicVocabulary> listTopics = [];

  final _topicListVocabularyFetcher = PublishSubject<List<TopicVocabulary>>();

  final _topicEventController = StreamController<TopicVocabularyEvent>();

  Sink<TopicVocabularyEvent> get topicEventSink => _topicEventController.sink;

  Stream<List<TopicVocabulary>> get resultListTopics => _topicListVocabularyFetcher.stream;


  TopicVocabularyBloc() {
    _topicEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TopicVocabularyEvent event) {
    if(event is SearchTopicVocabularyEvent){
      List<TopicVocabulary> listSearchResult = [];
      for (var topic in listTopics){
        if(topic.name.contains(event.searchQuery)) {
          listSearchResult.add(topic);
        }
      }
      _topicListVocabularyFetcher.sink.add(listSearchResult);
    }
  }

  fetchAllTopics() async {
    listTopics = await TopicVocabularyService.getAllTopicVocabulary();
    _topicListVocabularyFetcher.sink.add(listTopics);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _topicListVocabularyFetcher.close();
    _topicEventController.close();
  }

}
