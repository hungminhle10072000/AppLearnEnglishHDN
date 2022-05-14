import 'package:app_learn_english/presentation/widgets/NavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../utils/constants/color_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String fullname = "";
  String email = "";
  String avatar = "";

  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fullname = pref.getString('fullname')!;
      email = pref.getString('email')!;
      avatar = pref.getString('avartar')!;
    });

  }

  final controller = CarouselController();

  int activeIndex = 0;

  List imgs = [
    'assets/images/studyingenglish.jpg',
    'assets/images/banner1.jpg',
    'assets/images/pe-academy.jpg',
    'assets/images/learnEngilish.jpg'
  ];

  var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 14,
      color: Color.fromRGBO(63, 63, 63, 1));

  void animateToSlide(int index) => controller.animateToPage(index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(this.fullname, this.avatar, this.email),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'English 2022',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
            // IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
          elevation: 0,
        ),
        backgroundColor: mBackgroundColor,
        body: SafeArea(
            child: Column(
          children: <Widget>[
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: imgs.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = imgs[index];

                  return buidImage(urlImage, index);
                },
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index))),
            SizedBox(
              height: 20,
            ),
            buildIndicator(),
            SizedBox(
              height: 20,
            ),
            new Expanded(
                child: GridView.count(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              crossAxisCount: 2,
              children: [
                GestureDetector(
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
                          'Từ vựng',
                          style: cardTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'listGrammar');
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
                            image: AssetImage('assets/images/grammar.jpg'),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 128,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ngữ pháp',
                          style: cardTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'listCourses');
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
                            image: AssetImage('assets/images/course.jpg'),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 128,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Khóa học',
                          style: cardTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/listExercise');
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
                            image: AssetImage('assets/images/practice.jpg'),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 128,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Luyện tập',
                          style: cardTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/statistical');
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
                            image: AssetImage('assets/images/statistical.jpg'),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 128,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Thống kê',
                          style: cardTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: Image(
                          image: AssetImage('assets/images/author.jpg'),
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 128,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Thông tin tác giả',
                        style: cardTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        )));
  }

  Widget buidImage(String urlImage, int index) => Container(
        width: MediaQuery.of(context).size.width,
        child: Image(
            image: AssetImage(urlImage),
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.fill),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgs.length,
        onDotClicked: animateToSlide,
        effect: JumpingDotEffect(dotWidth: 20, dotHeight: 20),
      );
}
