import 'package:app_learn_english/blocs/statistical_bloc.dart';
import 'package:app_learn_english/models/statistical_model.dart';
import 'package:app_learn_english/states/current_user_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../events/statistical_event.dart';
import '../../models/bar_chart_model.dart';
import '../../states/statistical_state.dart';

class StatisticalPage extends StatefulWidget {
  const StatisticalPage({Key? key}) : super(key: key);

  @override
  _StatisticalPageState createState() => _StatisticalPageState();
}

class _StatisticalPageState extends State<StatisticalPage> {
  late StatisticalBloc _statisticalBloc = StatisticalBloc();
  List<BarChartModel> data = [
    BarChartModel(
      daysOfTheWeek: "Thứ 2",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
    ),
    BarChartModel(
      daysOfTheWeek: "Thứ 3",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      daysOfTheWeek: "Thứ 4",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      daysOfTheWeek: "Thứ 5",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    BarChartModel(
      daysOfTheWeek: "Thứ 6",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      daysOfTheWeek: "Thứ 7",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    BarChartModel(
      daysOfTheWeek: "Chủ Nhật",
      score: 0,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  void initState() {
    _statisticalBloc = BlocProvider.of<StatisticalBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "score",
        data: data,
        domainFn: (BarChartModel series, _) => series.daysOfTheWeek,
        measureFn: (BarChartModel series, _) => series.score,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<StatisticalBloc, StatisticalState>(
              builder: (context, state) {
                if (state is StatisticalStateInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is StatisticalStateFailure) {
                  return const Center(
                    child: Text(
                      'Cannot load data from Server',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  );
                }
                if (state is StatisticalStateSuccess) {
                  List<BarChartModel> newStatisticalModel = data;
                  List<StatisticalModel> statisticalData =
                      state.statisticalMaster.statisticalDtoList;
                  const int numDaysOfWeek = 7;
                  if (statisticalData.length == numDaysOfWeek) {
                    for (int i = 0; i < numDaysOfWeek; i++) {
                      newStatisticalModel[i].score = statisticalData[i].score;
                    }
                  } else {
                    for (int i = 0; i < numDaysOfWeek; i++) {
                      newStatisticalModel[i].score = 0;
                    }
                  }
                  if (newStatisticalModel != data) {
                    setState(() {
                      data = newStatisticalModel;
                    });
                  }

                  return Column(
                      children: [
                        Row(
                           children: [
                             MaterialButton(
                                 height: 50.0,
                                 color: Colors.deepPurpleAccent,
                                 textColor: Colors.white,
                                 padding: EdgeInsets.zero,
                                 child: const Text("Tuần này",
                                 style: TextStyle(fontSize: 14),),
                                 minWidth: MediaQuery.of(context).size.width/4,
                                 shape: const RoundedRectangleBorder(side: BorderSide(
                                     color: Colors.deepPurple,
                                     width: 1,
                                     style: BorderStyle.solid
                                 ),),
                                 onPressed: () {
                                   CurrentUserState.WeekAgo = 0;
                                   Navigator.pushNamed(context, '/statistical');
                                 }
                             ),
                             MaterialButton(
                                 height: 50.0,
                                 color: Colors.deepPurpleAccent,
                                 textColor: Colors.white,
                                 padding: EdgeInsets.zero,
                                 child: const Text("Tuần trước",
                                   style: TextStyle(fontSize: 14),
                                 ),
                                 minWidth: MediaQuery.of(context).size.width/4,
                                 shape: const RoundedRectangleBorder(side: BorderSide(
                                     color: Colors.deepPurple,
                                     width: 1,
                                     style: BorderStyle.solid
                                 ),),
                                 onPressed: () {
                                   CurrentUserState.WeekAgo = 1;
                                   Navigator.pushNamed(context, '/statistical');
                                   // final StatisticalFetchedAgoEvent event = StatisticalFetchedAgoEvent(1);
                                   // _statisticalBloc.add(event);
                                 }
                             ),
                             MaterialButton(
                                 height: 50.0,
                                 color: Colors.deepPurpleAccent,
                                 textColor: Colors.white,
                                 padding: EdgeInsets.zero,
                                 child: const Text("2 tuần trước",
                                   style: TextStyle(fontSize: 14),
                                 ),
                                 minWidth: MediaQuery.of(context).size.width/4,
                                 shape: const RoundedRectangleBorder(side: BorderSide(
                                     color: Colors.deepPurple,
                                     width: 1,
                                     style: BorderStyle.solid
                                 ),),
                                 onPressed: () {
                                   final StatisticalFetchedAgoEvent event = StatisticalFetchedAgoEvent(2);
                                   _statisticalBloc.add(event);
                                 }
                             ),
                             MaterialButton(
                                 height: 50.0,
                                 color: Colors.deepPurpleAccent,
                                 padding: EdgeInsets.zero,
                                 textColor: Colors.white,
                                 child: const Text("3 tuần trước",
                                 style: TextStyle(fontSize: 14),),
                                 minWidth: MediaQuery.of(context).size.width/4,
                                 shape: const RoundedRectangleBorder(side: BorderSide(
                                     color: Colors.deepPurple,
                                     width: 1,
                                     style: BorderStyle.solid
                                 ),),
                                 onPressed: () {
                                   final StatisticalFetchedAgoEvent event = StatisticalFetchedAgoEvent(3);
                                   _statisticalBloc.add(event);
                                 }
                             ),
                           ],
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                            height: height*0.7,
                            child: charts.BarChart(series, animate: true)),
                        Stack(
                          children: [
                            UserAccountsDrawerHeader(
                              accountName: Text(state.statisticalMaster.fullname),
                              accountEmail: Text(
                                state.statisticalMaster.streak.toString() + ' STREAK',
                                style: const TextStyle(
                                    fontSize: fontSize.medium,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              currentAccountPicture: CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: height - height * 0.7,
                                  ),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 130, right: 10, top: 30),
                              child: Column(
                                children: [
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: state.statisticalMaster.process,
                                    center: Text((state.statisticalMaster.process * 100).toString()+ "%"),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.green,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (state.statisticalMaster.currentScore).toString()+"/1000",
                                    style: const TextStyle(
                                        fontSize: fontSize.medium,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],

                  );
                }
                return const Center(child: Text('Other state'));
              },
            )
            // ),
          ],
        ),
      ),
    );
  }
}
