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
  late ChewieController _chewieController;
  final utube = RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  late String dataSource;
  final Map<String,String> linkk = {"dataSource": ""};

  Widget _renderVideo() {
    return utube.hasMatch(linkk['dataSource'] ?? '') ? _buildVideoYoutubeContainer() : _buildVideoPlayContainer();
  }

  Widget _buildVideoYoutubeContainer() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          margin: EdgeInsets.all(8),
          child: YoutubePlayer(
            controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(linkk['dataSource'] ?? '') ?? '',
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                )),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blue,
            progressColors: ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent),
          ),
        ));
  }

  Widget _buildVideoPlayContainer() {
    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(linkk['dataSource'] ?? ""),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
    double width = MediaQuery.of(context).size.width - 2*4;
    double height = width * 9 / 16;


    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: height,
        child: Chewie(
          controller: _chewieController,
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
                title: Text(e.headerValue),
              );
            },
            body: Container(
              child: Column(
                children:
                  e.chapterModel.lessons.map((e) =>
                      ListTile(
                        title: Text('${e.name}'),
                        // subtitle:
                        // Text('to delele this panel, tap the trash can icon'),
                        trailing: Icon(Icons.delete),
                        onTap: () {
                          setState(() {
                            // _data.removeWhere((element) => e == element);
                            linkk['dataSource'] = e.video;
                            print('re-render${linkk['dataSource']}');
                          });
                        },
                      )
                  ).toList(),
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
    linkk['dataSource'] = widget.courseDetail.chapters.first.lessons.first.video;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Video"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _renderVideo(),
              Container(
                child: Column(
                  children: [_buildListPanel()],
                ),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController.dispose();
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
  return
    courseModel.chapters.map((e) => Item(
      headerValue: '${e.name}',
      expandedValue: '${e.courseName}',
        chapterModel: e
    )).toList();
}

/*

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (index) {
    return Item(
        headerValue: 'Panel $index',
        expandedValue: 'This is item number $index');
  });
}
*/









// Chewie Player

/*


class CourseDetailPage extends StatelessWidget {
  final CourseModel courseDetail;

  const CourseDetailPage({Key? key,required this.courseDetail}) : super(key: key);



  Widget _buildListPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((e) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context,bool isExpanded) {
              print(isExpanded);
              return ListTile(
                title: Text(e.headerValue),
              );
            },
            body: Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text('f'),
                    subtitle: Text('to delele this panel, tap the trash can icon'),
                    trailing: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        _data.removeWhere((element) => e == element);
                      });
                    },
                  ),
                  ListTile(
                    title: Text('f'),
                    subtitle: Text('to delele this panel, tap the trash can icon'),
                    trailing: Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        _data.removeWhere((element) => e == element);
                      });
                    },
                  )
                ],
              ),
            ),
            isExpanded: e.isExpanded
        );
      }).toList(),
    );
  }

  // final utube = RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                        initialVideoId: YoutubePlayer.convertUrlToId(
                            courseDetail.introduce),
                        flags: YoutubePlayerFlags(
                          autoPlay: false,
                        )),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blue,
                    progressColors: ProgressBarColors(
                        playedColor: Colors.blue,
                        handleColor: Colors.blueAccent),
                  ),
                )
            ),
            Container(

            )
          ],
        )
    );
  }
}


*/
