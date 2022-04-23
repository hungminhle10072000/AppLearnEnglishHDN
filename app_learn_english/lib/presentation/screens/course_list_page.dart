import 'package:app_learn_english/blocs/course_bloc.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/presentation/screens/course_detail_page.dart';
import 'package:app_learn_english/states/course_state.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/StringRenderUtil.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseListPage();
  }
}

class _CourseListPage extends State<CourseListPage> {
  // late CourseBloc _courseBloc;
  bool isSearching = false;
  final searchController = TextEditingController();
  late String keyword='';

  @override
  void initState() {
    // TODO: implement initState
    // _courseBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: !isSearching
            ? TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ))
            : null,
        title: !isSearching
            ? const Text(
          "Khoá học",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800),
        )
            : TextField(
          controller: searchController,
          onChanged: (text) {
            setState(() {
              keyword = text;
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: GestureDetector(
                onTap: () {
                  print('OnTap 1');
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
                  setState(() {
                    keyword = '';
                  });
                  searchController.clear();
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Danh Sách Khoá Học", style: TextStyle(fontSize: fontSize.large, fontWeight: FontWeight.bold),),
            BlocBuilder<CourseBloc,CourseState>(
              builder: (context,state) {
                if (state is CourseStateInitial) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                if (state is CourseStateFailure) {
                  return const Center(
                    child: Text('Connot load comments from Server',
                      style: TextStyle(fontSize: 22, color: Colors.red),),
                  );
                }
                if (state is CourseStateSuccess) {
                  if (state.courses.length > 0) {
                    List<CourseModel> currentCourses = [];
                    if (keyword.isEmpty) {
                      currentCourses = state.courses;
                    } else {
                      currentCourses = state.courses.where((element) => StringRenderUtil.searching(element.name, keyword)).toList();
                    }
                    if (currentCourses.length < 1) {
                      return const Center(
                        child: Text('Không tìm thấy kết quả!',
                          style: TextStyle(fontSize: fontSize.medium, color: Colors.redAccent),),
                      );
                    }
                    return Expanded(
                        child: SizedBox(
                          height: 400,
                          child:  ListView.builder(itemExtent: 125, itemBuilder: (BuildContext buildContext,int index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child:  ListTile(
                                dense: true,
                                visualDensity: VisualDensity(vertical: 3),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => CourseDetailPage(courseDetail:currentCourses[index]))
                                  );
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                tileColor: const Color.fromRGBO(
                                    173, 173, 173, 0.30196078431372547),

                                leading:  Container(
                                  width: 100,
                                  height: 100,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: currentCourses[index].image,
                                    fit: BoxFit.fitHeight,
                                    width: 100,
                                    height: 100,),),
                                title: Text(StringRenderUtil.reduceSentence(currentCourses[index].name,45), style: const TextStyle(fontSize: fontSize.medium, fontWeight: FontWeight.bold, letterSpacing: -0.3, wordSpacing: -0.3 ),),
                                isThreeLine: true,
                                subtitle: Text(StringRenderUtil.reduceSentence(currentCourses[index].introduce,70) ,style: TextStyle(fontSize: fontSize.small, letterSpacing: -0.3, wordSpacing: -0.3, ),),
                              ),
                            );
                          },
                            itemCount: currentCourses.length,
                          ),
                        )
                    );
                  } else {
                    return const Center(child: Text('Course Empty'));
                  }
                }
                return const Center(child: Text('Other state'));
              },
            )
          ],
        ),
      ),
    );
  }
}
