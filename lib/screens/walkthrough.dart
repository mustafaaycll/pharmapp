import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pharm_app/main.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState(){
    return _WalkThroughState();
  }
}
class _WalkThroughState extends State<WalkThrough> {
    @override
  Widget build(BuildContext context){
      return IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            bodyWidget: introScreen(
              context,
              1,
              'WELCOME',
              'Awesome Pharmacy Application',
              'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
            ),
            title: '',
          ),
          PageViewModel(
            bodyWidget: introScreen(
              context,
              2,
              'PROFILE',
              'Create Your Profile Easily',
              'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
            ),
            title: '',
          ),
          PageViewModel(
            bodyWidget: introScreen(
              context,
              3,
              'CONTENT',
              'Search Whatever You Want',
              'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
            ),
            title: '',
          ),
          PageViewModel(
            bodyWidget: introScreen(
              context,
              4,
              'SHOP',
              'Get It Instantly',
              'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
            ),
            title: '',
          ),
        ],

        onDone: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar()),
                (Route<dynamic> route) => false,
          );
        },
        onSkip: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar()),
                (Route<dynamic> route) => false,
          );
        },
        showSkipButton: true,

        skipFlex: 0,
        nextFlex: 0,
        skip: const Text(
          'Skip',
          style: TextStyle(
             color: const Color(0xff393E41),
          ),
        ),
        next: const Text(
          'Next',
          style: TextStyle(
              color: const Color(0xff393E41),
          ),
        ),
        done: const Text(
          'Welcome Screen',
          style: TextStyle(
            color: const Color(0xff393E41),
          ),
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0,10.0),
          color: Colors.black12,
          activeSize: Size(22.0,10.0),
          activeColor: Colors.black,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      );
    }


}

Widget introScreen(BuildContext context, int? pageId, String? pageTitle,
String? bodyText, String? imagePath) {
  var size = MediaQuery.of(context).size;
  return (
      Column(
        children: [
          Column(
            children: [
              SizedBox(
                width: 10.0,
                height: 20.0,
              ),
              Text(
                pageTitle!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(
                  width: 10.0,
                  height: 50.0,
              ),
              Image.network(
                  'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
              ),
              SizedBox(
                width: 10.0,
                height: 100.0,
              ),
              Text(
                bodyText!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ],
          ),
        ],
      ));
}
