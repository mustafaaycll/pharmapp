import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';


class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Basket',
          style: TextStyle(
            color: AppColors.titleText,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0.0,

        ),

      body: PageView(
        children: [
          SingleChildScrollView(
            child: Center(
              child:
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                    SizedBox(height: 8,),

                    ListTile(
                        title: Text('itemInBasket'),
                        subtitle:Text("Price: XYZ\$"),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                      ),
                      ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Text('itemInBasket'),
                      subtitle:Text("Price: XYZ\$"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                    
                    SizedBox(height: 20),

                    Align(
                      alignment: FractionalOffset.bottomCenter,
                        child:
                        Row(
                            children:[
                              Align(
                                alignment: FractionalOffset.bottomLeft,
                                child: Text(


                                  '   Total Price: XXX\$',
                                  style: TextStyle(
                                    color: AppColors.bodyText,
                                    fontSize: 23,
                                  ),


                                ),

                              ),
                              SizedBox(width: 20),
                              Align(

                                alignment: FractionalOffset.bottomRight,
                                child: OutlinedButton(
                                  child:
                                  Text(
                                    'Check Out',
                                    style: TextStyle(
                                      color: AppColors.bodyText,
                                      fontSize: 26,
                                    ),
                                  ),
                                  onPressed: () {},

                                ),
                              ),


                            ]

                        ),

                    )



                ],
                ),
           ),
          ),



        ],
      ),
    );
  }
}
