import 'package:equatable/equatable.dart';

class VocabularyModel extends Equatable {
  final int id;
  final String image;
  final String content;
  // final String transcribe;
  final String mean_example_vocabulary;
  final String mean;
  final String explain_vocabulary;
  final String example_vocabulary;
  final String file_audio;

  VocabularyModel(
      this.id,
      this.image,
      this.content,
      // this.transcribe,
      this.mean_example_vocabulary,
      this.mean,
      this.explain_vocabulary,
      this.example_vocabulary,
      this.file_audio);

  factory VocabularyModel.fromJson(Map<String, dynamic> data) {
    return VocabularyModel(
        data['id'],
        data['image'],
        data['content'],
        // data['transcribe'],
        data['mean_example_vocabulary'],
        data['mean'],
        data['explain_vocabulary'],
        data['example_vocabulary'],
        data['file_audio']);
  }

  @override
  List<Object> get props => [
        id,
        image,
        content,
        // transcribe,
        mean_example_vocabulary,
        mean,
        explain_vocabulary,
        example_vocabulary,
        file_audio
      ];
}
