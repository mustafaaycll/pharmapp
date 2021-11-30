import 'package:flutter/material.dart';
import 'package:pharm_app/screens/home.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int currentPage = 0;
  int lastPage = 3;
  List<String> titles = [
    'Welcome',
    'Introduction',
    'Profile',
    'Content',
  ];
  List<String> headingTitles = [
    'Awesome Pharmacy App',
    'Signup Easily',
    'Create Your Profile',
    'Start Shopping',
  ];
  List<String> imageURLs = [
    'https://www.forumistanbul.com.tr/media/image/eczane.jpg',
    'https://i4.hurimg.com/i/hurriyet/75/750x422/603e27e64e3fe10db08b8792.jpg',
    'https://www.ankarafirma.net/wp-content/uploads/2020/05/ankara-nobetci-eczaneler-1.jpg',
    'https://medyascope.tv/wp-content/uploads/2020/03/eccec.jpg',
  ];
  List<String> captions = [
    'UUUUU',
    'ZZZZZ',
    'YYYYY',
    'XXXXX',
  ];
  
    
    
  void nextPage(){
    if(currentPage < lastPage) {
      setState(() {
        currentPage += 1;
      });
    }
    else if(currentPage == lastPage){
      setState(() {
        Navigator.pushNamed(context, '/home'); // eğer walkthrough nun son sayfasındaysa, nextpage'e basıldığında home sayfasına gider.

      });
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7EB),
      appBar: AppBar(
        backgroundColor: const Color(0xffE94F37),
        title: Text(
          titles[currentPage].toUpperCase(),
          style: TextStyle(
            color: const Color(0xffF6F7EB),
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  headingTitles[currentPage],
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff393E41),
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            Container(
              height: 280,
              child: CircleAvatar(
                backgroundColor: const Color(0xffE94F37),
                radius: 140,
                backgroundImage: NetworkImage(imageURLs[currentPage]),
              ),
            ),
            Center(
              child: Text(
                captions[currentPage],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w200,
                  letterSpacing: -1,
                  color: const Color(0xff393E41),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: prevPage,
                      child: Text(
                        'Previous Page',
                        style: TextStyle(
                          color: const Color(0xff393E41),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${currentPage + 1}/${lastPage + 1}',
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: nextPage,
                      child: Text(
                        'Next Page',
                        style: TextStyle(
                          color: const Color(0xff393E41),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
