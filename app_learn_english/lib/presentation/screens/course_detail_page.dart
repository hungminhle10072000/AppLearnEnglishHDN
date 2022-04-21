import 'package:app_learn_english/models/chapter_model.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/models/lesson_model.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late ChewieController _chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(dataSource),
  );
  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  late String dataSource="Initial";
  late YoutubePlayerController controller;

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
                    child:Text(lessonName,style: const TextStyle(fontSize: fontSize.large, fontWeight:FontWeight.bold, color: Colors.blue),),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildListPanel()
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
          title: Text("Bài học"),
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
            _buildListPanel()
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
                title: Text(e.headerValue, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              );
            },
            body: Container(
              child: Column(
                children: e.chapterModel.lessons
                    .map((e) => ListTile(
                          contentPadding: const EdgeInsets.only(left: 25),
                          title: Text(e.name, style: TextStyle(color: Colors.black87),),
                          onTap: () {
                            if (!utube.hasMatch(dataSource)) {
                              _chewieController.pause();
                            }
                            if (utube.hasMatch(e.video) &&
                                utube.hasMatch(dataSource)) {
                              controller.load(
                                  YoutubePlayer.convertUrlToId(e.video) ?? '');
                              setState(() {
                                lessonName = e.name;
                              });
                            } else if (!utube.hasMatch(e.video) &&
                                !utube.hasMatch(dataSource)) {
                              _buildVideoPlayContainer();
                              setState(() {
                                lessonName = e.name;
                              });
                            } else {
                              setState(() {
                                dataSource = e.video;
                                lessonName = e.name;
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
