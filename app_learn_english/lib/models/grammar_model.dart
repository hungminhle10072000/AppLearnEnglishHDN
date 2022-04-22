import 'package:equatable/equatable.dart';

class GrammarModel extends Equatable {
  final int id;
  final String content;
  final String name;

  GrammarModel(this.id, this.content, this.name);

  factory GrammarModel.fromJson(Map<String, dynamic> data) {
    return GrammarModel(data['id'], data['content'], data['name']);
  }

  @override
  List<Object> get props => [id, content];
}
