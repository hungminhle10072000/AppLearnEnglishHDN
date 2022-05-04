import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndExercisePage extends StatelessWidget {
  final List<ResultDetailModel> resultDetail;
  const EndExercisePage({Key? key, required this.resultDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Kết quả"),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Kết quả của bạn", style: TextStyle(fontSize: fontSize.large, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 20,
                ),
                Text("0/${resultDetail.length}",style: const TextStyle(fontSize: fontSize.medium)),
                const SizedBox(
                  height: 20,
                ),
                Text("${0/resultDetail.length*100}%",style: const TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {

                      },
                      minWidth: 120.0,
                      color: Colors.green,
                      child: const Text("Xem lại KQ", style: TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    MaterialButton(
                      onPressed: () {
                      },
                      minWidth: 120.0,
                      color: Colors.green,
                      child: const Text("Làm lại", style: TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold,color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
