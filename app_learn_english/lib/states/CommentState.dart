import 'package:equatable/equatable.dart';
abstract class CommentState extends Equatable {
  const CommentState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CommentStateInitial extends CommentState {}
class CommentStateFailure extends CommentState {}
class CommentStateSuccess extends CommentState {}

