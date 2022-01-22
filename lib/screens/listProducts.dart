// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/bookmarks/bookmarks.dart';
import 'package:pharm_app/models/comments/comments.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/products/products.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:intl/intl.dart';


class listProductScreen extends StatefulWidget {
  const listProductScreen({Key? key}) : super(key: key);

  @override
  _listProductScreenState createState() => _listProductScreenState();
}

class _listProductScreenState extends State<listProductScreen> {
  final _formKey = GlobalKey<FormState>();
  num multiplier = 1;
  bool approved = false;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final user = Provider.of<User?>(context);
    pharmappPharmacy pharm = arguments['pharm'];

    return StreamBuilder<pharmappUser>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          pharmappUser? pUser = snapshot.data;
          if (pUser != null) {
            return StreamBuilder<List<pharmappProduct?>>(
                stream: DatabaseService_product(id: "", ids: pharm.products)
                    .products,
                builder: (context, snapshot) {
                  List<pharmappProduct?>? products = snapshot.data;
                  if (products != null && products.length != 0) {
                    return StreamBuilder<List<pharmappComment?>>(
                      stream: DatabaseService_comment(id: "", ids: pharm.comments).comments,
                      builder: (context, snapshot) {
                        List<pharmappComment?>? comments = snapshot.data;
                        if (comments != null && comments.length != 0) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(
                                'Products',
                                style: TextStyle(
                                    color: AppColors.titleText, fontSize: 26),
                              ),
                              backgroundColor: AppColors.primary,
                              centerTitle: true,
                              elevation: 0.0,
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/basket');
                                  },
                                  icon: Icon(Icons.shopping_basket),
                                )
                              ],
                            ),
                            body: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 75,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: PageView(
                                        controller: PageController(),
                                        children: [
                                          productList(products, pUser, pharm),
                                          commentList(comments)
                                        ]
                                      ),
                                    ),
                                  ],
                                )),
                          );} else if (comments == null) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    'Products',
                                    style: TextStyle(
                                        color: AppColors.titleText, fontSize: 26),
                                  ),
                                  centerTitle: true,
                                  backgroundColor: AppColors.primary,
                                  elevation: 0.0,
                                ),
                                body: Center(
                                  child: Text(
                                    'Fetching Data',
                                    style: TextStyle(
                                        color: AppColors.bodyText, fontSize: 15),
                                  ),
                                ),
                              );
                          } else {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    'Products',
                                    style: TextStyle(
                                        color: AppColors.titleText, fontSize: 26),
                                  ),
                                  backgroundColor: AppColors.primary,
                                  centerTitle: true,
                                  elevation: 0.0,
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/basket');
                                      },
                                      icon: Icon(Icons.shopping_basket),
                                    )
                                  ],
                                ),
                                body: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 75,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: PageView(
                                            controller: PageController(),
                                            children: [
                                              productList(products, pUser, pharm),
                                              commentList([])
                                            ]
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }
                      }
                    );
                  } else if (products == null) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Products',
                          style: TextStyle(
                              color: AppColors.titleText, fontSize: 26),
                        ),
                        centerTitle: true,
                        backgroundColor: AppColors.primary,
                        elevation: 0.0,
                      ),
                      body: Center(
                        child: Text(
                          'Fetching Data',
                          style: TextStyle(
                              color: AppColors.bodyText, fontSize: 15),
                        ),
                      ),
                    );
                  } else {
                    return StreamBuilder<List<pharmappComment?>>(
                      stream: DatabaseService_comment(id: "", ids: pharm.comments).comments,
                      builder: (context, snapshot) {
                        List<pharmappComment?>? comments = snapshot.data;
                        if (comments != null && comments.length != 0) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(
                                'Products',
                                style: TextStyle(
                                    color: AppColors.titleText, fontSize: 26),
                              ),
                              backgroundColor: AppColors.primary,
                              centerTitle: true,
                              elevation: 0.0,
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/basket');
                                  },
                                  icon: Icon(Icons.shopping_basket),
                                )
                              ],
                            ),
                            body: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 75,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: PageView(
                                        controller: PageController(),
                                        children: [
                                          productList(products, pUser, pharm),
                                          commentList(comments)
                                        ]
                                      ),
                                    ),
                                  ],
                                )),
                          );
                          } else if (comments == null) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    'Products',
                                    style: TextStyle(
                                        color: AppColors.titleText, fontSize: 26),
                                  ),
                                  centerTitle: true,
                                  backgroundColor: AppColors.primary,
                                  elevation: 0.0,
                                ),
                                body: Center(
                                  child: Text(
                                    'Fetching Data',
                                    style: TextStyle(
                                        color: AppColors.bodyText, fontSize: 15),
                                  ),
                                ),
                              );
                          } else {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    'Products',
                                    style: TextStyle(
                                        color: AppColors.titleText, fontSize: 26),
                                  ),
                                  backgroundColor: AppColors.primary,
                                  centerTitle: true,
                                  elevation: 0.0,
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/basket');
                                      },
                                      icon: Icon(Icons.shopping_basket),
                                    )
                                  ],
                                ),
                                body: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 75,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: PageView(
                                            controller: PageController(),
                                            children: [
                                              productList(products, pUser, pharm),
                                              commentList([])
                                            ]
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }
                      }
                    );
                  }
                });
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Pharmacies',
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
  }

  Widget commentList(List<pharmappComment?> comments) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Comments',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 8,
            ),
            comments.isEmpty ?
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sorry, there is no comment",),
                  ],
                ),
              ],
            ) :
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return StreamBuilder<pharmappUser?>(
                  stream: DatabaseService(uid: comments[index]!.userid).userData,
                  builder: (context, snapshot) {
                    pharmappUser? commenter = snapshot.data;
                    if (commenter != null) {
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          leading: SizedBox(
                            height: 40,
                            width: 40,
                            child: rateBox(comments[index]!.rate),
                          ),
                          title: Text(comments[index]!.comment),
                          subtitle: Text('${commenter.fullname} - ${DateFormat('dd-MM-yyyy').format(comments[index]!.date)}'),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(commenter.profile_pic_url),
                          ),
                        ),
                      );
                    }
                    else {
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: rateBox(comments[index]!.rate),
                          ),
                          title: Text(comments[index]!.comment),
                          subtitle: Text('${DateFormat('dd-MM-yyyy').format(comments[index]!.date)}'),
                        ),
                      );
                    }
                  }
                );
              },
            ),
          ]
        ),
      ),
    );
  }

  Widget productList(List<pharmappProduct?> products, pharmappUser pUser, pharmappPharmacy pharm) {
    
    if (products.isEmpty) {
      return Column(
        children: [
          SizedBox(
                height: 8,
          ),
          Row(
            children: [
              Text(
                'Products',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          SizedBox(
              height: 8,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sorry, there is no comment",),
            ],
          )
        ],
      );
    } else {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                'Painkillers',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 8,
              ),
              products.where((element) => element!.category == "Painkiller").toList().isEmpty ?
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No products under the category of painkillers"),
                    ],
                  ),
                ],
              ) : listProductsByCategory('Painkiller', products, pUser, pharm),
              SizedBox(
                height: 16,
              ),
              Text(
                'Dental Care',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 8,
              ),
              products.where((element) => element!.category == "Dental Care").toList().isEmpty ?
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No products under the category of dental care"),
                    ],
                  ),
                ],
              ) : listProductsByCategory("Dental Care", products, pUser, pharm),
              SizedBox(
                height: 16,
              ),
              Text(
                'Personal Care',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 8,
              ),
              products.where((element) => element!.category == "Personal Care").toList().isEmpty ?
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No products under the category of personal care"),
                    ],
                  ),
                ],
              ) : listProductsByCategory("Personal Care", products, pUser, pharm),
              SizedBox(
                height: 16,
              ),
              Text(
                'Supplementary',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 8,
              ),
              products.where((element) => element!.category == "Supplementary").toList().isEmpty ?
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No products under the category of supplementary"),
                    ],
                  ),
                ],
              ) : listProductsByCategory("Supplementary", products, pUser, pharm),
            ],
          ),
        ),
      );
    }
  }

  Widget listProductsByCategory(String cat, List<pharmappProduct?> products, pharmappUser pUser, pharmappPharmacy pharm) {
    List<dynamic> pre_bookmarks = pUser.bookmarks;
    return StreamBuilder<List<pharmappBookmark?>>(
      stream: DatabaseService_bookmark(id: "", ids: pUser.bookmarks).bookmarks,
      builder: (context, snapshot) {
        List<pharmappBookmark?>? bookmarks = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.where((element) => element!.category == cat).toList().length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () async {
                  await addToBasketPopUp(context,pUser,pharm,products.where((element) =>element!.category == cat).toList()[index]);
                  if (approved) {
                    await DatabaseService(uid: pUser.id).addToBasket(pharm, products.where((element) =>element!.category == cat).toList()[index]!,pUser,multiplier);
                    setState(() {
                      approved = false;
                    });
                  }
                  setState(() {
                    multiplier = 1;
                  });
                },
                leading: SizedBox(
                    height: 75,
                    width: 75,
                    child: Image.network(products.where((element) =>element!.category == cat).toList()[index]!.url)
                ),
                title: Text(products.where((element) => element!.category == cat).toList()[index]!.name),
                subtitle: Text('${products.where((element) => element!.category == cat).toList()[index]!.price} ₺'),
                trailing: IconButton(
                  icon: DatabaseService(uid: pUser.id).bookmarkExists(products.where((element) => element!.category == cat).toList()[index]!.id, pharm.id, bookmarks) ?
                  Icon(Icons.bookmark, color: AppColors.button,) : Icon(Icons.bookmark_outline),
                  onPressed: () async {
                    if (!DatabaseService(uid: pUser.id).bookmarkExists(products.where((element) => element!.category == cat).toList()[index]!.id, pharm.id, bookmarks)) {
                      await AuthService().addBookmark(pharm.id, products.where((element) => element!.category == cat).toList()[index]!.id, pUser.id, DateFormat('dd-MM-yyyy').format(DateTime.now()), pre_bookmarks);
                    } else {
                      await DatabaseService(uid: pUser.id).removeBookmarkFromUser(products.where((element) => element!.category == cat).toList()[index]!.id, pharm.id, bookmarks);
                    }
                  },
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget rateWidget(pharmappPharmacy pharm) {
    double avgRate = double.parse((pharm.ratings.reduce((a, b) => a + b) / pharm.ratings.length).toString());
    if (avgRate != 0) {
      return Column(
        children: [
          SizedBox(
            width: 60,
            height: 35,
            child: avgRateBox(avgRate),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Swipe left to see comments")
        ],
      );
    } else {
      return Text('No Rating');
    }
  }

  Future<dynamic>? addToBasketPopUp(BuildContext context, pharmappUser pUser,
      pharmappPharmacy pharm, pharmappProduct? product) async {
    if (pUser.currentSeller != "" && pUser.currentSeller != pharm.id) {
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'There are products from other sellers in your basket',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    } else {
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
                            child: Image.network(product!.url)),
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
                            buttonArrangement:
                                ButtonArrangement.incRightDecLeft,
                            controller: TextEditingController(),
                            min: 1,
                            max: 10,
                            initialValue: 1,
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
                                    Navigator.pop(context);
                                    setState(() {
                                      approved = true;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          color: AppColors.buttonText),
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
  }

  Widget rateBox(int rate) {
    if (rate <= 10 && rate >= 8) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xff57e32c)
        ),
        child: Center(
          child: Text(rate.toString(), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else if (rate < 8 && rate >= 6 ){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffb7dd29)
        ),
        child: Center(
          child: Text(rate.toString(), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else if (rate < 6 && rate >= 4){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffffa534)
        ),
        child: Center(
          child: Text(rate.toString(), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffff4545)
        ),
        child: Center(
          child: Text(rate.toString(), style: TextStyle(color: AppColors.titleText, fontSize: 23, fontWeight: FontWeight.w900),),
        ),
      );
    }
  }
  Widget avgRateBox(double rate) {
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
}
