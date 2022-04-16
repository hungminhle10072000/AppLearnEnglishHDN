class TopicVocabulary {

  final int id;
  final String image;
  final String name;

  TopicVocabulary(this.id,this.image,this.name);

  factory TopicVocabulary.fromJson(Map<String, dynamic> data) {
    return TopicVocabulary(
        data['id'],
        data['image'],
        data['name']
    );
  }

}