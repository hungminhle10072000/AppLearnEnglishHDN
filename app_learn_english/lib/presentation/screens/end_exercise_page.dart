import 'package:app_learn_english/blocs/result_detail_bloc.dart';
import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:app_learn_english/states/result_detail_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EndExercisePage extends StatelessWidget {
  final List<ResultDetailModel> resultDetail;
  const EndExercisePage({Key? key, required this.resultDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numOfCorrect = 0;
    for (var value in resultDetail) {
      if (value.userAnswer.trim() == value.correctAnswer.trim()) {
        numOfCorrect++;
      }
    }
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
                BlocBuilder<ResultDetailBloc,ResultDetailState>(
                builder: (context,state) {
                  if (state is ResultDetailInitial) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if (state is ResultDetailFailure) {
                    return const Center(
                      child: Text('Something went wrong!',
                        style: TextStyle(fontSize: 22, color: Colors.red),),
                    );
                  }
                  if (state is ResultDetailSuccess) {
                    return const Center(
                      child: Text('ResultDetailSuccess',
                        style: TextStyle(fontSize: 22, color: Colors.red),),
                    );
                  }
                  return const Center(
                    child: Text('Something went wrong!',
                      style: TextStyle(fontSize: 22, color: Colors.red),),
                  );
                }),
                const Text("Kết quả của bạn", style: TextStyle(fontSize: fontSize.large, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 20,
                ),
                Text("$numOfCorrect/${resultDetail.length}",style: const TextStyle(fontSize: fontSize.medium)),
                const SizedBox(
                  height: 20,
                ),
                Text("${numOfCorrect/resultDetail.length*100}%",style: const TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        showDialogFunc(context,resultDetail);
                      },
                      minWidth: 120.0,
                      color: Colors.green,
                      child: const Text("Xem lại KQ", style: TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    MaterialButton(
                      onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
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

  displayResultDetail() {
    return
    resultDetail.map<Widget>((e) {
      bool isCorrect = e.correctAnswer == e.userAnswer;
      return
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("- ${e.contentQuestion}",
                style: const TextStyle(
                    fontSize: fontSize.medium,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(5),
                color: isCorrect ? Colors.green : Colors.red,
                width: 10000,
                child: Text("ĐA của bạn: ${e.userAnswer}",
                  style: TextStyle(
                      fontSize: fontSize.medium,
                      color: Colors.white,
                      backgroundColor: isCorrect ? Colors.green : Colors.red),),
              ),

              const SizedBox(height: 10,),
              !isCorrect ? Container(
                padding: const EdgeInsets.all(5),
                color: Colors.blueAccent,
                width: 10000,
                child: !isCorrect ? Text("ĐA đúng: ${e.correctAnswer}",
                style: const TextStyle(
                    fontSize: fontSize.medium,
                    color: Colors.white,
                    backgroundColor: Colors.blueAccent),) : const SizedBox(height: 0,)
              ) : const SizedBox(height: 0,),
              const SizedBox(height: 10,)
            ],
          ),
        );
    }).toList();

  }

  showDialogFunc(BuildContext context, List<ResultDetailModel> resultDetails) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kết quả của bạn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: fontSize.large),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ...displayResultDetail()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
