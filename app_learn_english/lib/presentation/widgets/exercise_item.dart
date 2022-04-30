import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'topicVocabulary');
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: Image(
                image: AssetImage('assets/images/vocabulary.jpg'),
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 128,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'Từ vựng'
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
