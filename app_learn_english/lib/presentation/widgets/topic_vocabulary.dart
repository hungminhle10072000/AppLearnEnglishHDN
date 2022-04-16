import 'package:flutter/material.dart';

import '../../models/topic_vocabulary_model.dart';


class topic_vocabulary extends StatelessWidget {

  final TopicVocabulary topic;

  topic_vocabulary(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2), height: 140,
      child: Card(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 10,),
            Expanded(child:  Image.network(topic.image, width: 100, height: 100,),),
            Expanded(child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(topic.name, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue)),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
