import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(
              color: AppColors.titleText,
              fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: [IconButton(
          onPressed: buttonPressed,
          //onPressed: (){
            //Navigator.pushNamed(context, '/filters');
          //},
          icon: Icon(
            Icons.settings, // filtreleme iconu gelecek.
            color: Colors.white,
          ),
        ),
        ],
      ),
      body: PageView(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Painkillers',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Dental Care',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Cosmetics',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Vitamins',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Non-Prescription Drugs',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed,//onpressed is gonna be changed
                    child: Text(
                      'Category6',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                  OutlinedButton(
                    onPressed: buttonPressed, //onpressed is gonna be changed
                    child: Text(
                      'Category7',
                      style: TextStyle(
                          color: AppColors.bodyText,
                          fontSize: 26,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.secondary50percent,
                      minimumSize: Size(375.0,100.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// wont be used.
void buttonPressed(){
  print('Button tapped');
}


