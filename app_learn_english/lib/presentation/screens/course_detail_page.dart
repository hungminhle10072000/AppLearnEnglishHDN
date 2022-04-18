import 'package:app_learn_english/models/chapter_model.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/presentation/screens/forgetPasswordPage.dart';
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
  late List<Item> _data = [];
  late ChewieController _chewieController = ChewieController(
    videoPlayerController: VideoPlayerController.network(dataSource),
  );
  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  late String dataSource;
  late YoutubePlayerController controller;

  Widget _renderVideo() {
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
                title: const Text("Youtube Player"),
              ),
              body: ListView(
                children: [
                  player,
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String url =
                            'https://www.youtube.com/watch?v=PlVlWl8kKmg';
                        controller.load(YoutubePlayer.convertUrlToId(url)!);
                      },
                      child: Text('Next Video')),
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
              style: TextStyle(color: Colors.white),
            ),
          );
        });
    double width = MediaQuery.of(context).size.width;
    double height = width * 9 / 16;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Video"),
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
    print('Re-render');
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
                title: Text(e.headerValue),
              );
            },
            body: Container(
              child: Column(
                children: e.chapterModel.lessons
                    .map((e) => ListTile(
                          title: Text('${e.name}'),
                          trailing: Icon(Icons.delete),
                          onTap: () {
                            if (!utube.hasMatch(dataSource)) {
                              _chewieController.pause();
                            }

                            if (utube.hasMatch(e.video) &&
                                utube.hasMatch(dataSource)) {
                              controller.load(
                                  YoutubePlayer.convertUrlToId(e.video) ?? '');
                            } else if (!utube.hasMatch(e.video) &&
                                !utube.hasMatch(dataSource)) {
                              _buildVideoPlayContainer();
                            } else {
                              setState(() {
                                dataSource = e.video;
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
    dataSource = widget.courseDetail.chapters.first.lessons.first.video;
    _data = createChapterItems(widget.courseDetail);
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(dataSource)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: true,
        ));
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
          headerValue: '${e.name}',
          expandedValue: '${e.courseName}',
          chapterModel: e))
      .toList();
}
