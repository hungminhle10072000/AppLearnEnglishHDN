import 'package:app_learn_english/events/comment_event.dart';
import 'package:app_learn_english/states/CommentState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/comment_service.dart';
class CommentBloc extends Bloc<CommentEvent,CommentState> {
  CommentBloc() : super(CommentStateInitial()) {
    on<CommentEventAdd>(_onAddComment);
  }
  void _onAddComment(CommentEventAdd event, Emitter<CommentState> emit) async {
    final isSuccess = await addComment(event.commentModel);
    if (isSuccess) {
      emit(CommentStateSuccess());
    } else {
      emit(CommentStateFailure());
    }

  }
}