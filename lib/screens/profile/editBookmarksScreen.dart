import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/bookmarks/bookmarks.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/products/products.dart';
import 'package:intl/intl.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:pharm_app/screens/listProducts.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class editBookmarksScreen extends StatefulWidget {
  const editBookmarksScreen({ Key? key }) : super(key: key);

  @override
  _editBookmarksScreenState createState() => _editBookmarksScreenState();
}

class _editBookmarksScreenState extends State<editBookmarksScreen> {
  final _formKey = GlobalKey<FormState>();
  num multiplier = 1;
  bool approved = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<pharmappUser>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        pharmappUser? pUser = snapshot.data;

        if (pUser != null) {
          List<dynamic> bookmarkIDs = pUser.bookmarks;
          return StreamBuilder<List<pharmappBookmark?>>(
            stream: DatabaseService_bookmark(id: "", ids: bookmarkIDs).bookmarks,
            builder: (context, snapshot) {
              List<pharmappBookmark?>? bookmarks = snapshot.data;
              if (bookmarks != null && bookmarks.isNotEmpty){
                return StreamBuilder<List<pharmappProduct?>>(
                  stream: DatabaseService_product(id: "", ids: pUser.basket).products,
                  builder: (context, snapshot) {
                    List<pharmappProduct?>? currentBasket = snapshot.data;
                    
                    if (currentBasket != null) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Bookmarks',
                            style:
                                TextStyle(color: AppColors.titleText, fontSize: 26),
                          ),
                          centerTitle: true,
                          backgroundColor: AppColors.primary,
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
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: bookmarks.length,
                            itemBuilder: (context, index) {
                              return StreamBuilder<pharmappProduct>(
                                stream: DatabaseService_product(id: bookmarks[index]!.productid, ids: []).productData,
                                builder: (context, snapshot) {
                                  pharmappProduct? product = snapshot.data;
                                  return StreamBuilder<pharmappPharmacy>(
                                    stream: DatabaseService_pharm(id: bookmarks[index]!.pharmid, ids: []).pharmData,
                                    builder: (context, snapshot) {
                                      pharmappPharmacy? pharm = snapshot.data;
                                      return Card(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(4),
                                          onTap: () {},
                                          leading: SizedBox(
                                                  width: 75,
                                                  child: Image.network(product!.url)
                                          ),
                                          title: Text(product.name),
                                          subtitle: Text("${product.price.toStringAsFixed(2)}₺\n${pharm!.name}\nSaved on ${DateFormat("dd-MM-yyyy").format(bookmarks[index]!.date)}"),
                                          isThreeLine: true,
                                          trailing: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  await DatabaseService(uid: pUser.id).removeBookmarkFromUser(product.id, pharm.id, bookmarks);
                                                },
                                                icon: Icon(Icons.bookmark_remove_outlined),
                                              ),
                                              IconButton(
                                                onPressed: () async{
                                                  if (pUser.basket.contains(product.id) && pUser.currentSeller == pharm.id) {
                                                    await DatabaseService(uid: pUser.id).removeSingleProductFromBasket(pUser.amount, locationOfRelevantProductInBasket(currentBasket, product), currentBasket, pUser.currentSeller);
                                                  } else {
                                                    await addToBasketPopUp(context,pUser,pharm,product);
                                                    if (approved) {
                                                      await DatabaseService(uid: pUser.id).addToBasket(pharm, product, pUser,multiplier);
                                                      setState(() {
                                                        approved = false;
                                                      });
                                                    }
                                                    setState(() {
                                                      multiplier = 1;
                                                    });
                                                  }
                                                },
                                                icon: pUser.basket.contains(product.id) && pUser.currentSeller == pharm.id ?
                                                  Icon(Icons.shopping_cart, color: AppColors.button,) :
                                                  Icon(Icons.shopping_cart_outlined),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                }
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Bookmarks',
                            style:
                                TextStyle(color: AppColors.titleText, fontSize: 26),
                          ),
                          centerTitle: true,
                          backgroundColor: AppColors.primary,
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
                        body: Center(
                          child: Text(
                            'Retrieving Basket Data',
                            style:
                                TextStyle(color: AppColors.bodyText, fontSize: 30),
                          ),
                        ),
                      );
                    }
                  }
                );
              } else if (bookmarks == null) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Bookmarks',
                      style:
                          TextStyle(color: AppColors.titleText, fontSize: 26),
                    ),
                    centerTitle: true,
                    backgroundColor: AppColors.primary,
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
                  body: Center(
                    child: Text(
                      'Fetching Bookmarks',
                      style:
                          TextStyle(color: AppColors.bodyText, fontSize: 30),
                    ),
                  ),
                );
              } else  {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Bookmarks',
                      style:
                          TextStyle(color: AppColors.titleText, fontSize: 26),
                    ),
                    centerTitle: true,
                    backgroundColor: AppColors.primary,
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
                  body: Center(
                    child: Text(
                      'No Bookmark Stored',
                      style:
                          TextStyle(color: AppColors.bodyText, fontSize: 30),
                    ),
                  ),
                );
              }
            }
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Bookmarks',
                style: TextStyle(color: AppColors.titleText, fontSize: 26),
              ),
              centerTitle: true,
              backgroundColor: AppColors.primary,
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
            body: Center(
              child: Text(
                'Connecting',
                style: TextStyle(color: AppColors.bodyText, fontSize: 30),
              ),
            ),
          );
        }
      }
    );
  }

  int locationOfRelevantProductInBasket (List<pharmappProduct?>? currBasket, pharmappProduct? product) {
    int loc = 0;
    
    for (var i = 0; i < currBasket!.length; i++) {
      if (currBasket[i]!.id == product!.id) {
        loc = i;
        break;
      }
    }

    return loc;
  }
  Future<dynamic>? addToBasketPopUp(BuildContext context, pharmappUser pUser, pharmappPharmacy pharm, pharmappProduct? product) async {
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
        }
      );
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
        }
      );
    }
  }
}