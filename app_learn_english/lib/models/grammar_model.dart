import 'package:equatable/equatable.dart';

class GrammarModel extends Equatable {
  final int id;
  final String content;

  GrammarModel(this.id, this.content);

  factory GrammarModel.fromJson(Map<String, dynamic> data) {
    return GrammarModel(data['id'], data['content']);
  }

  @override
  List<Object> get props => [id, content];
}
