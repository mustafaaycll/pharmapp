import 'package:flutter/material.dart';
import 'package:pharm_app/screens/components/app_text_button.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'PharMapp',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              DropdownButton(
                hint: Text('Select Address'),
                items: [],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child:
                            AppTextButton(isClicked: isClicked, name: 'Orders'),
                      ),
                      Expanded(
                        child: AppTextButton(
                            isClicked: isClicked, name: 'Favorites'),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.primary),
                    ),
                    width: double.infinity,
                    height: 100,
                    child: ListView(
                      children: [
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  )
                ],
              ),
              Row(children: [
                Expanded(
                    child: AppTextButton(
                        isClicked: isClicked, name: 'Special Offers'))
              ])
            ],
          ),
        ),
      ),
    );
  }

  BubbleNavigationBar bottomNavBar() {
    return BubbleNavigationBar(
      opacity: .3,
      items: [
        BubbleBarItem(
          backgroundColor: Colors.deepPurple,
          icon: Icon(
            Icons.home,
          ),
          activeIcon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BubbleBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.add_circle_outline_outlined,
            color: Colors.green,
          ),
          title: Text("Add"),
        ),
        BubbleBarItem(
          backgroundColor: Colors.pinkAccent,
          icon: Icon(
            Icons.person,
          ),
          title: Text(
            "Profile",
          ),
        ),
        BubbleBarItem(
          backgroundColor: Colors.deepPurple,
          icon: Icon(
            Icons.home,
          ),
          activeIcon: Icon(Icons.home),
          title: Text("Home"),
        ),
      ],
    );
  }
}
