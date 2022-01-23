// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/products/products.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  final _formKey = GlobalKey<FormState>();
  num multiplier = 1;
  bool approved = false;
  late int itemNum; 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return StreamBuilder<pharmappUser>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            pharmappUser? pUser = snapshot.data;
            if (pUser != null) {
              String currentSeller = pUser.currentSeller;
              List<dynamic> basketids = pUser.basket;
              List<dynamic> amounts = pUser.amount;

              if (currentSeller != "") {
                return StreamBuilder<pharmappPharmacy>(
                    stream: DatabaseService_pharm(id: currentSeller, ids: [])
                        .pharmData,
                    builder: (context, snapshot) {
                      pharmappPharmacy? pharm = snapshot.data;

                      if (pharm != null) {
                        return StreamBuilder<List<pharmappProduct?>>(
                            stream:
                                DatabaseService_product(id: "", ids: basketids)
                                    .products,
                            builder: (context, snapshot) {
                              List<pharmappProduct?>? products = snapshot.data;
                              if (products != null && products.length != 0) {
                                return Scaffold(
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
                                    actions: [
                                      IconButton(
                                        onPressed: () {
                                          DatabaseService(uid: pUser.id).removeAllFromBasket();
                                        },
                                        icon: Icon(Icons.delete_rounded,),
                                      )
                                    ],
                                  ),
                                  body: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Shopping From',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 75,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                'http://www.aeo.org.tr/Helpers/DuyuruIcon.ashx?yayinyeri=sayfaicerik&Id=36690',
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          pharm.name,
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        rateWidget(pharm),
                                        //Text(
                                        //    'Rating: ${pharm.ratings.reduce((a, b) => a + b) / pharm.ratings.length}'),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Products in basket are',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: products.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: ListTile(
                                                          onTap: () async {
                                                            setState(() {
                                                              multiplier = amounts[index +1];
                                                            });
                                                            await changeQuantityPopUp(context,products[index]);
                                                            if (approved == true) {
                                                              await DatabaseService(uid: pUser.id)
                                                                  .changeAmount(amounts,index + 1,multiplier);
                                                              setState(() {
                                                                approved = false;
                                                              });
                                                            }
                                                            setState(() {
                                                              multiplier = 1;
                                                            });
                                                          },
                                                          leading: Row(
                                                            mainAxisSize:MainAxisSize.min,
                                                            children: [
                                                              CircleAvatar(
                                                                child: Text(
                                                                  'x${amounts[index + 1]}',
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: amounts[index + 1] <= 100 ? 15 : 10),
                                                                ),
                                                                radius: 15,
                                                                backgroundColor:AppColors.button,
                                                              ),
                                                              SizedBox(
                                                                  height: 75,
                                                                  width: 75,
                                                                  child: Image.network(products[index]!.url)),
                                                            ],
                                                          ),
                                                          title: Text(
                                                              products[index]!
                                                                  .name),
                                                          subtitle: Text(
                                                              '${(products[index]!.price * amounts[index + 1]).toStringAsFixed(2)}₺\n(Each: ${products[index]!.price.toStringAsFixed(2)}₺)'),
                                                          trailing: IconButton(
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color: Color(0xffE13419),
                                                              ),
                                                              onPressed: () async {
                                                                await DatabaseService(uid: pUser.id).removeSingleProductFromBasket(amounts, index, products, currentSeller);
                                                              })),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${totalCost(products, amounts)}₺',
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () async {
                                                    List<dynamic> amountsToSent = [];
                                                    List<String> productsToSent = [];
                                                    List<String> pricesToSent = [];
                                                    for (var i = 0; i < products.length; i++) {
                                                      amountsToSent.add(amounts[i+1]);
                                                      productsToSent.add(products[i]!.name);
                                                      pricesToSent.add(products[i]!.price.toStringAsFixed(2));
                                                    }
                                                    await AuthService().addOrder(pUser.id, pharm.id, pharm.name, amountsToSent, productsToSent, pricesToSent, DateFormat("dd-MM-yyyy").format(DateTime.now()), totalCost(products, amounts), false, pUser.pre_orders);
                                                    await DatabaseService(uid: pUser.id).removeAllFromBasket();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.check, color: AppColors.buttonText, size: 20,),
                                                      SizedBox(width: 10),
                                                      Text("Check Out",style: TextStyle(color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: Dimen
                                                            .boxBorderRadius),
                                                    backgroundColor:
                                                        AppColors.secondary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (products == null) {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      'Basket',
                                      style: TextStyle(
                                          color: AppColors.titleText,
                                          fontSize: 26),
                                    ),
                                    centerTitle: true,
                                    backgroundColor: AppColors.primary,
                                    elevation: 0.0,
                                  ),
                                  body: Center(
                                    child: Text(
                                      'Fetching Basket Data',
                                      style: TextStyle(
                                          color: AppColors.bodyText,
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              } else {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      'Basket',
                                      style: TextStyle(
                                          color: AppColors.titleText,
                                          fontSize: 26),
                                    ),
                                    centerTitle: true,
                                    backgroundColor: AppColors.primary,
                                    elevation: 0.0,
                                  ),
                                  body: Center(
                                    child: Text(
                                      'Basket Has No Product',
                                      style: TextStyle(
                                          color: AppColors.bodyText,
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              }
                            });
                      } else {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(
                              'Basket',
                              style: TextStyle(
                                  color: AppColors.titleText, fontSize: 26),
                            ),
                            centerTitle: true,
                            backgroundColor: AppColors.primary,
                            elevation: 0.0,
                          ),
                          body: Center(
                            child: Text(
                              'Fetching Pharm Data',
                              style: TextStyle(
                                  color: AppColors.bodyText, fontSize: 30),
                            ),
                          ),
                        );
                      }
                    });
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Basket',
                      style:
                          TextStyle(color: AppColors.titleText, fontSize: 26),
                    ),
                    centerTitle: true,
                    backgroundColor: AppColors.primary,
                    elevation: 0.0,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                                'assets/cartfadeout.png', width: 200,),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Basket seems to be empty',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.bodyText, fontSize: 15),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/editBookmarks');
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.bookmark, color: AppColors.buttonText, size: 20,),
                                        SizedBox(width: 10),
                                        Text("Bookmarks",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    style:
                                        OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: Dimen
                                              .boxBorderRadius),
                                      backgroundColor:
                                          AppColors.button,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Basket',
                    style: TextStyle(color: AppColors.titleText, fontSize: 26),
                  ),
                  centerTitle: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0.0,
                ),
                body: Center(
                  child: Text(
                    'Connecting',
                    style: TextStyle(color: AppColors.bodyText, fontSize: 30),
                  ),
                ),
              );
            }
          });
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Basket',
            style: TextStyle(color: AppColors.titleText, fontSize: 26),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0.0,
        ),
        body: Center(
          child: Text(
            'No User Logged In',
            style: TextStyle(color: AppColors.bodyText, fontSize: 30),
          ),
        ),
      );
    }
  }
  Widget rateWidget(pharmappPharmacy pharm) {
    double avgRate = double.parse((pharm.ratings.reduce((a, b) => a + b) / pharm.ratings.length).toString());
    print(avgRate);
    if (avgRate != 0) {
      return SizedBox(
        width: 60,
        height: 35,
        child: avgRateBox(avgRate),
      );
    } else {
      return Text('No Rating');
    }
  }
  Widget avgRateBox(double rate) {
    print('a: ${rate.toStringAsFixed(1)}');
    if (rate <= 10 && rate >= 8) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xff57e32c)
        ),
        child: Center(
          child: Text(rate.toStringAsFixed(1), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else if (rate < 8 && rate >= 6 ){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffb7dd29)
        ),
        child: Center(
          child: Text(rate.toStringAsFixed(1), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else if (rate < 6 && rate >= 4){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffffa534)
        ),
        child: Center(
          child: Text(rate.toStringAsFixed(1), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffff4545)
        ),
        child: Center(
          child: Text(rate.toStringAsFixed(1), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    }
  }

  Future<dynamic>? changeQuantityPopUp(
      BuildContext context, pharmappProduct? product) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network(product!.url),
                      ),
                      Text(product.name),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NumberInputPrefabbed.roundedButtons(
                          incIcon: Icons.add,
                          decIcon: Icons.remove,
                          incIconColor: Colors.white,
                          decIconColor: Colors.white,
                          style: TextStyle(fontSize: 20),
                          numberFieldDecoration:
                              InputDecoration(border: InputBorder.none),
                          widgetContainerDecoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.white,
                          )),
                          incDecBgColor: AppColors.button,
                          buttonArrangement: ButtonArrangement.incRightDecLeft,
                          controller: TextEditingController(),
                          min: 1,
                          max: double.infinity,
                          initialValue: multiplier,
                          validator: (value) {
                            if (value == null) {
                              return "Field is empty";
                            } else {
                              return null;
                            }
                          },
                          onSubmitted: (value) {
                            setState(() {
                              multiplier = value;
                            });
                          },
                          onIncrement: (value) {
                            setState(() {
                              multiplier = value;
                            });
                          },
                          onDecrement: (value) {
                            setState(() {
                              multiplier = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              multiplier = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    approved = true;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Change',
                                    style:
                                        TextStyle(color: AppColors.buttonText),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: Dimen.boxBorderRadius),
                                  backgroundColor: AppColors.button,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  String totalCost(List<pharmappProduct?> products, List<dynamic> amounts) {
    List<double> costs = [];

    for (var i = 0; i < products.length; i++) {
      costs.add(products[i]!.price * amounts[i + 1]);
    }

    return costs.sum.toStringAsFixed(2);
  }
}
