abstract class TopicVocabularyEvent {

}

class SearchTopicVocabularyEvent extends TopicVocabularyEvent {

  final String _searchQuery;

  String get searchQuery => _searchQuery;

  SearchTopicVocabularyEvent(this._searchQuery);

}