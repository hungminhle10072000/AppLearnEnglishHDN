import 'package:app_learn_english/blocs/course_bloc.dart';
import 'package:app_learn_english/presentation/screens/course_detail_page.dart';
import 'package:app_learn_english/states/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseListPage();
  }
}

class _CourseListPage extends State<CourseListPage> {
  late CourseBloc _courseBloc;

  @override
  void initState() {
    // TODO: implement initState
    _courseBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Khoá học",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CourseBloc,CourseState>(
          builder: (context,state) {
            if (state is CourseStateInitial) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (state is CourseStateFailure) {
              return Center(
                child: Text('Connot load comments from Server',
                  style: TextStyle(fontSize: 22, color: Colors.red),),
              );
            }
            if (state is CourseStateSuccess) {
              if (state.courses.length > 0) {
                return ListView.builder(itemBuilder: (BuildContext buildContext,int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child:  ListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: 3),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CourseDetailPage(courseDetail:state.courses[index]))
                        );
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      tileColor: Color.fromRGBO(
                          173, 173, 173, 0.30196078431372547),

                      leading:  Container(
                        width: 100,
                        height: 100,
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: state.courses[index].image,
                            fit: BoxFit.fitHeight,
                            width: 100,
                            height: 100,),),
                      title: Text(state.courses[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      isThreeLine: true,
                      subtitle: Text(state.courses[index].introduce),
                    ),
                  );
                },
                  itemCount: state.courses.length,

                );
              } else {
                return Center(child: Text('Course Empty'));
              }
            }
            return Center(child: Text('Other state'));
          },
        ),
      ),
    );
  }
}
