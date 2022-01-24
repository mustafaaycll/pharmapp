import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';

//categories are going to be fixed?

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Image.asset('assets/painkillers.png'),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Text("Painkillers", style: TextStyle(fontSize: 20),),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text("List products",style:TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.button,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Image.asset('assets/supplementary.png'),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Text("Supplementaries", style: TextStyle(fontSize: 20),),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text("List products",style:TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.button,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Image.asset('assets/dental_care.png'),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Text("Dental Care", style: TextStyle(fontSize: 20),),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text("List products",style:TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.button,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Image.asset('assets/personal_care.png'),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Text("Personal Care", style: TextStyle(fontSize: 20),),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text("List products",style:TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.button,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}


