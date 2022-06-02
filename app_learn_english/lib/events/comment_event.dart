import 'package:equatable/equatable.dart';

import '../models/comment_model.dart';

abstract class CommentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CommentEventAdd extends CommentEvent {
  final CommentModel commentModel;
  CommentEventAdd(this.commentModel);
}