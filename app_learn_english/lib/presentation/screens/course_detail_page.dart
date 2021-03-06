import 'package:app_learn_english/models/chapter_model.dart';
import 'package:app_learn_english/models/comment_model.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/models/lesson_model.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/StringRenderUtil.dart';
import '../widgets/comment_item.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseModel courseDetail;
  const CourseDetailPage({Key? key, required this.courseDetail})
      : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late String lessonName="Initial";
  late List<Item> _data = [];
  late int lessonCurrentId = -1;
  late ChewieController _chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(dataSource),
  );
  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  late String dataSource="Initial";
  late YoutubePlayerController controller;
  bool isComment = false;
  List commentsData = [];

  Widget _renderVideo() {
    if (dataSource == "Initial") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Bài học"),
        ),
        body: SafeArea(
          child: Center(
            child: Text("Khoá học chưa được phát hành", style: TextStyle(fontSize: fontSize.large, fontWeight:  FontWeight.bold),),
          ),
        ),
      );
    }
    return utube.hasMatch(dataSource)
        ? _buildVideoYoutubeContainer()
        : _buildVideoPlayContainer();
  }

  Widget _buildVideoYoutubeContainer() {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) => Scaffold(
          appBar: AppBar(
            title: const Text("Bài học"),
          ),
          body: ListView(
            children: [
              player,
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child:Text(StringRenderUtil.reduceSentence(lessonName, 45),style: const TextStyle(fontSize: fontSize.large, fontWeight:FontWeight.bold, color: Colors.blue),),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                    height: 30.0,
                    minWidth:  MediaQuery.of(context).size.width/2-10,
                    color: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        isComment = false;
                      });
                    },
                    child:  const Text("Tổng quan", style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  MaterialButton(
                    height: 30.0,
                    minWidth: MediaQuery.of(context).size.width/2-10,
                    color: Colors.blueAccent,
                    onPressed: () {
                      setState(() {
                        isComment = true;
                      });
                    },
                    child:  const Text("Bình luận", style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),),
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),

              isComment ? CommentItem(commentsData, lessonCurrentId) : _buildListPanel()
            ],
          ),
        ));
  }

  Widget _buildVideoPlayContainer() {
    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(dataSource),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: false,
        autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
    double width = MediaQuery.of(context).size.width;
    double height = width * 9 / 16;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Bài học 2"),
        ),
        body: ListView(
          children: [
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 4),
              height: height,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child:Text(StringRenderUtil.reduceSentence(lessonName, 45),style: const TextStyle(fontSize: fontSize.large, fontWeight:FontWeight.bold, color: Colors.blue),),
            ),
            isComment ? CommentItem(commentsData, lessonCurrentId) : _buildListPanel()
          ],
        ));
  }

  Widget _buildListPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((e) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(StringRenderUtil.reduceSentence(e.headerValue,60) , style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              );
            },
            body: Container(
              child: Column(
                children: e.chapterModel.lessons
                    .map((e) => ListTile(
                          contentPadding: const EdgeInsets.only(left: 25),
                          title: Text(StringRenderUtil.reduceSentence(e.name, 80), style: const TextStyle(color: Colors.black87),),
                          onTap: () {
                            List<CommentModel> commentsModel = e.commentsModel;
                            List newcommentsData = [];
                            int newLessonCurrentId = e.id;
                            if (commentsModel.isNotEmpty) {
                              newcommentsData = commentsModel.map((e) {
                                return {
                                  'name': e.userDto.fullname ?? '',
                                  'pic': e.userDto.avartar.isNotEmpty
                                      ? e
                                      .userDto.avartar
                                      : 'https://picsum.photos/300/30',
                                  'message': e.content.isNotEmpty
                                      ? e.content
                                      : 'I love code'
                                };
                              }).toList();
                            }
                            if (!utube.hasMatch(dataSource)) {
                              _chewieController.pause();
                            }
                            if (utube.hasMatch(e.video) &&
                                utube.hasMatch(dataSource)) {
                              controller.load(
                                  YoutubePlayer.convertUrlToId(e.video) ?? '');
                              setState(() {
                                lessonName = e.name;
                                commentsData = newcommentsData;
                                lessonCurrentId = newLessonCurrentId;
                              });
                            } else if (!utube.hasMatch(e.video) &&
                                !utube.hasMatch(dataSource)) {
                              _buildVideoPlayContainer();
                              setState(() {
                                lessonName = e.name;
                                commentsData = newcommentsData;
                                lessonCurrentId = newLessonCurrentId;
                              });
                            } else {
                              setState(() {
                                dataSource = e.video;
                                lessonName = e.name;
                                commentsData = newcommentsData;
                                lessonCurrentId = newLessonCurrentId;
                              });
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
            isExpanded: e.isExpanded);
      }).toList(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataSource = widget.courseDetail.chapters.first.lessons.first.video ?? "";
    // lessonName = widget.courseDetail.chapters.first.lessons.first.name ?? "";

    List<ChapterModel> chapters = widget.courseDetail.chapters;
    if (chapters.isEmpty) {
      dataSource = "Initial";
    } else {
      List<LessonModel> lessons = chapters.first.lessons;
      if (lessons.isEmpty) {
        dataSource = "Initial";
      }
      else {
        List<CommentModel> commentsModel = lessons.first.commentsModel;
        lessonCurrentId = lessons.first.id;
        if (commentsModel.isNotEmpty) {
          commentsData = commentsModel.map((e) {
            return {
              'name': e.userDto.fullname ?? '',
              'pic': e.userDto.avartar.isNotEmpty ? e.userDto.avartar : 'https://picsum.photos/300/30',
              'message': e.content.isNotEmpty ? e.content : 'I love code'
            };
          }).toList();
        }
        dataSource = lessons.first.video;
        lessonName = lessons.first.name;
        _data = createChapterItems(widget.courseDetail);
        controller = YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(dataSource)!,
            flags: const YoutubePlayerFlags(
              mute: false,
              loop: false,
              autoPlay: true,
            ));
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return _renderVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController.pause();
    _chewieController.dispose();
    controller.dispose();
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  ChapterModel chapterModel;
  Item(
      {required this.expandedValue,
      required this.headerValue,
      required this.chapterModel,
      this.isExpanded = false});
}

List<Item> createChapterItems(CourseModel courseModel) {
  return courseModel.chapters
      .map((e) => Item(
          headerValue: e.name,
          expandedValue: e.courseName,
          chapterModel: e))
      .toList();
}
