import 'package:app_learn_english/blocs/list_vocabulary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePracticeTotalVocabulary extends StatefulWidget {
  const HomePracticeTotalVocabulary({Key? key}) : super(key: key);

  @override
  State<HomePracticeTotalVocabulary> createState() =>
      _HomePracticeTotalVocabularyState();
}

class _HomePracticeTotalVocabularyState
    extends State<HomePracticeTotalVocabulary> {
  double _count = 10;

  void _incrementCount() {
    if (_count < 100) {
      setState(() {
        _count++;
      });
    }
  }

  void _decrementCount() {
    if (_count > 10) {
      setState(() {
        _count--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tổng ôn từ vựng",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
              "Số lượng từ vựng",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.green),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: _decrementCount,
                  child: Icon(
                    Icons.remove,
                  ),
                  backgroundColor: Colors.red,
                ),
                Text(
                  "${_count.round()}",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: _incrementCount,
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.red),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Slider(
                value: _count,
                activeColor: Colors.green,
                inactiveColor: Colors.red.shade100,
                label: _count.round().toString(),
                min: 10,
                max: 100,
                divisions: 90,
                onChanged: (value) => setState(() {
                      _count = value;
                    })),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context
                .read<ListVocabularyBloc>()
                .add(ListVocabularyRandomEventLoad(this._count));
                Navigator.pushNamed(context, 'practiceVocabulary');
              },
              child: Text(
                "Bắt đầu",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
