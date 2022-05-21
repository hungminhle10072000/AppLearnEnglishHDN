import 'package:flutter/material.dart';

import '../../blocs/topic_vocabulary_bloc.dart';
import '../../events/topic_vocabulary_event.dart';
import '../../models/topic_vocabulary_model.dart';
import '../widgets/topic_vocabulary_list_practice.dart';

class PracticeListTopic extends StatefulWidget {
  const PracticeListTopic({Key? key}) : super(key: key);

  @override
  State<PracticeListTopic> createState() => _PracticeListTopicState();
}

class _PracticeListTopicState extends State<PracticeListTopic> {
  TopicVocabularyBloc topicVocabularyBloc = new TopicVocabularyBloc();

  final searchController = TextEditingController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    topicVocabularyBloc.fetchAllTopics();
    topicVocabularyBloc.fetchAllTopics();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: !isSearching
              ? TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/listExercise');
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ))
              : null,
          title: !isSearching
              ? Text(
                  "Chọn chủ đề",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                )
              : TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      icon: GestureDetector(
                        onTap: () {
                          topicVocabularyBloc.topicEventSink.add(
                              SearchTopicVocabularyEvent(
                                  searchController.text.toString()));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Tìm kiếm..."),
                ),
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                        topicVocabularyBloc.topicEventSink
                            .add(SearchTopicVocabularyEvent(''));
                      });
                    },
                    icon: Icon(Icons.cancel))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                    icon: Icon(Icons.search))
          ],
        ),
        body: StreamBuilder(
          stream: topicVocabularyBloc.resultListTopics,
          builder: (BuildContext context,
              AsyncSnapshot<List<TopicVocabulary>> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.hasError);
            }
            List<TopicVocabulary> listTopics = snapshot.data ?? [];
            return snapshot.hasData
                ? TopicVocabularyListPractice(listTopics)
                : Center(child: CircularProgressIndicator());
          },
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    topicVocabularyBloc.dispose();
    super.dispose();
  }
}
