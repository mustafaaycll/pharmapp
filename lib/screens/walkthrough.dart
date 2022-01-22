import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pharm_app/main.dart';

class WalkThrough extends StatefulWidget {
  
  const WalkThrough({Key? key, required this.analytics, required this.observer}) : super(key: key);


  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  
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
            image: Image.asset('assets/pharm.png', width: 200,),
            bodyWidget: Text('Hey! Welcome to super easy online pharmacy shopping application where you can buy your needs instantly from close pharmacies.', textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            title: '',
          ),
          PageViewModel(
            image: Image.asset('assets/anon.png', width: 250,),
            bodyWidget: Text('You can easily create your profile and start shopping!\n\nPrivacy concerned? You can also continue anonymously.', textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            title: '',
          ),
          PageViewModel(
            image: Image.asset('assets/drug.png', width: 180,),
            bodyWidget: Text('Painkillers, personal care products and supplementaries..\n\nMore and more are here in PharMapp.', textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            title: '',
          ),
          PageViewModel(
            image: Image.asset('assets/cart.png', width: 200,),
            bodyWidget: Text('Shop instantly with secure purchase system.\n\nFor all and more, proceed to PharMapp!', textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),

            title: '',
          ),
        ],

        onDone: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar(analytics: widget.analytics, observer: widget.observer)),
                (Route<dynamic> route) => false,
          );
        },
        onSkip: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar(analytics: widget.analytics, observer: widget.observer,)),
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
          'Proceed to PharMapp',
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
