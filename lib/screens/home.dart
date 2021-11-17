import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleNavigationBar(
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
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'PharMapp',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
