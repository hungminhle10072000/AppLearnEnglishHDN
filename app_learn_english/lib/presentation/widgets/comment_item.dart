import 'package:app_learn_english/blocs/comment_bloc.dart';
import 'package:app_learn_english/events/comment_event.dart';
import 'package:app_learn_english/models/comment_model.dart';
import 'package:app_learn_english/models/user_model.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../states/current_user_state.dart';

var  commentCache = new Map();

class CommentItem extends StatefulWidget {
  List commentsData;
  final int lessonId;

  CommentItem(this.commentsData, this.lessonId);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late CommentBloc _commentBloc = CommentBloc();

  @override
  void initState() {
    _commentBloc = BlocProvider.of<CommentBloc>(context);
     if (commentCache.containsKey(widget.lessonId.toString())) {
     widget.commentsData = commentCache[widget.lessonId.toString()];
    }
    super.initState();
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.width * 9 / 16 - 190,
      child: CommentBox(
      userImage:
      "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
      child: commentChild(commentCache.containsKey(widget.lessonId.toString()) ? commentCache[widget.lessonId.toString()] : widget.commentsData),
      labelText: 'Write a comment...',
      withBorder: false,
      errorText: 'Comment cannot be blank',
      sendButtonMethod: () {
        if (formKey.currentState!.validate()) {
          print(commentController.text);
          setState(() {
            var value = {
              'name': CurrentUserState.fullname,
              'pic': CurrentUserState.avatar.isNotEmpty ? CurrentUserState.avatar :
              'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
              'message': commentController.text
            };
            widget.commentsData.insert(0, value);
          });
          commentCache[widget.lessonId.toString()] = widget.commentsData;
          FocusScope.of(context).unfocus();

          UserModel userModel =
            UserModel(id: CurrentUserState.id,
                fullname: CurrentUserState.fullname,
                username: CurrentUserState.username,
                password: '',
                email: '',
                gender: '',
                address: '',
                phonenumber: '',
                avartar: '',
                role: '',
                birthday: '');

          CommentModel commentModel =
            CommentModel(-1,
                commentController.text,
                DateTime.now(),
                '1',
                -1,
                -1,
                widget.lessonId,
                -1,
                CurrentUserState.id,
                userModel);
          final CommentEvent _commentEvent = CommentEventAdd(commentModel);
          commentController.clear();
          _commentBloc.add(_commentEvent);
        } else {
          print("Not validated");
        }
      },
      formKey: formKey,
      commentController: commentController,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
    ));
  }
}