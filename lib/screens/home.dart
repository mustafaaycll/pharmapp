import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:collection/collection.dart';

class Order {
  const Order(this.pharmacy, this.date, this.products, this.prices);
  final String pharmacy;
  final String date;
  final List<String> products;
  final List<double> prices;
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final _formKey = GlobalKey<FormState>();
  final _formKeyPopUp = GlobalKey<FormState>();
  final _formKeyRate = GlobalKey<FormState>();

  String? _currAddress;
  String? _addAddress;
  int _indexOrder = 0;
  int _indexPharm = 0;
  num rate = 1;
  bool approved = false;
  List<dynamic> pre_rates = [];

  List<Order> orders = <Order>[
    const Order('Faruk Eczanesi', '05/03/2021',
        ['Ortodontik Diş Fırçası', 'Apranax Fort Ağrı Kesici'], [57.0, 24.56]),
    const Order(
        'Güneş Eczanesi', '04/01/2021', ['Listerine Ağız Bakım'], [33.49]),
    const Order('Parlak Eczanesi', '25/10/2020',
        ['BreatheRight Burun Bandı', 'Batticon Tentürdiyot'], [42.49, 11.90]),
    const Order('Tuzla Eczanesi', '17/08/2020', [
      'Diş Fırçası',
      'Apranax Fort Ağrı Kesici',
      'Cımbız',
      'Sanitabant Yarabandı',
      'Gazlı Bez'
    ], [
      57.0,
      24.56,
      11.50,
      3.40,
      5.00
    ]),
    const Order('Sevgi Eczanesi', '04/06/2020',
        ['Cold Away C', 'Arveles Ağrı Kesici'], [10.0, 7.96])
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(
        context); //use this to check if the user is logged in

    if (user != null) {
      return StreamBuilder<pharmappUser>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            pharmappUser? pUser = snapshot.data;

            if (pUser != null) {
              List<dynamic> favPharms = pUser.fav_pharms;
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'PharMapp',
                    style: TextStyle(color: AppColors.titleText, fontSize: 26),
                  ),
                  backgroundColor: AppColors.primary,
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<pharmappAddress?>>(
                          stream: DatabaseService_address(
                                  id: "", ids: pUser.addresses)
                              .addrs,
                          builder: (context, snapshot) {
                            List<pharmappAddress?>? addrs = snapshot.data;

                            return Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: DropdownButtonFormField(
                                          isExpanded: true,
                                          isDense: true,
                                          hint: Text("Select a City"),
                                          items: addrs?.map((element) {
                                            return DropdownMenuItem(
                                              value: element!.id,
                                              child: Text(element.city),
                                            );
                                          }).toList(),
                                          onChanged: (String? val) {
                                            setState(() {
                                              _currAddress = val;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            await addAddressPopUp(
                                                context, pUser, addrs);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              'Add Address',
                                              style: TextStyle(
                                                  color: AppColors.buttonText),
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    Dimen.boxBorderRadius),
                                            backgroundColor: AppColors.button,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        flex: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (_currAddress != null) {
                                              Navigator.pushNamed(
                                                  context, '/listPharms',
                                                  arguments: {
                                                    'aid': _currAddress
                                                  });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              'List Pharmacies',
                                              style: TextStyle(
                                                  color: AppColors.buttonText),
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    Dimen.boxBorderRadius),
                                            backgroundColor:
                                                AppColors.secondary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(height: 20),
                      Text(
                        'Previous Orders',
                        style:
                            TextStyle(color: AppColors.bodyText, fontSize: 26),
                      ),
                      SizedBox(height: 15),
                      StreamBuilder<List<pharmappOrder?>>(
                          stream: DatabaseService_order(
                                  id: "", ids: pUser.pre_orders)
                              .orders,
                          builder: (context, snapshot) {
                            List<pharmappOrder?>? orders = snapshot.data;
                            if (orders != null && orders.length != 0) {
                              return SizedBox(
                                  height: 300,
                                  child: PageView.builder(
                                    itemCount: orders.length,
                                    controller:
                                        PageController(viewportFraction: 0.7),
                                    onPageChanged: (int index) =>
                                        setState(() => _indexOrder = index),
                                    itemBuilder: (_, i) {
                                      return Transform.scale(
                                        scale: i == _indexOrder ? 1 : 0.9,
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  Dimen.boxBorderRadius),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Card(
                                                color: AppColors
                                                    .secondary75percent,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        orders[i]!.pharmName,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        '${DateFormat('dd-MM-yyyy').format(orders[i]!.date)} \t ${orders[i]!.cost.toStringAsFixed(2)}₺',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: orders[i]!
                                                            .products
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Card(
                                                            child: ListTile(
                                                              dense: true,
                                                              onTap: () {},
                                                              leading:
                                                                  CircleAvatar(
                                                                child: Text(
                                                                  'x${orders[i]!.amounts[index]}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                radius: 15,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .button,
                                                              ),
                                                              title: Text(orders[
                                                                          i]!
                                                                      .products[
                                                                  index]),
                                                              subtitle: Text(
                                                                  'Each: ${double.parse(orders[i]!.prices[index])}₺'),
                                                              trailing: Text(
                                                                  '${double.parse(orders[i]!.prices[index]) * orders[i]!.amounts[index]}₺'),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: orders[i]!.rated != true
                                                    ? OutlinedButton(
                                                        onPressed: () async {
                                                          await ratePopUp(
                                                              context,
                                                              orders[i]!
                                                                  .pharmid,
                                                              orders[i]!
                                                                  .pharmName);
                                                          if (approved ==
                                                              true) {
                                                            await DatabaseService_pharm(
                                                                    id: orders[
                                                                            i]!
                                                                        .pharmid,
                                                                    ids: [])
                                                                .addRating(
                                                                    pre_rates,
                                                                    rate);
                                                            await DatabaseService_order(
                                                                    id: orders[
                                                                            i]!
                                                                        .id,
                                                                    ids: [])
                                                                .markRated();
                                                            setState(() {
                                                              approved = false;
                                                              pre_rates = [];
                                                              rate = 1;
                                                            });
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: AppColors
                                                                  .titleText,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Rate',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .buttonText,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: Dimen
                                                                  .boxBorderRadius),
                                                          backgroundColor:
                                                              AppColors.button,
                                                        ))
                                                    : OutlinedButton(
                                                        onPressed: () {},
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.check,
                                                              color: AppColors
                                                                  .titleText,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Already Rated',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .buttonText,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: Dimen
                                                                  .boxBorderRadius),
                                                          backgroundColor:
                                                              Colors.grey,
                                                        )),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            } else if (orders == null) {
                              return Text("Fetching");
                            } else {
                              return Text("There is no previous order");
                            }
                          }),
                      SizedBox(height: 20),
                      Text(
                        'Favourite Pharmacies',
                        style:
                            TextStyle(color: AppColors.bodyText, fontSize: 26),
                      ),
                      SizedBox(height: 15),
                      StreamBuilder<List<pharmappPharmacy?>>(
                          stream: DatabaseService_pharm(id: "", ids: favPharms)
                              .pharms,
                          builder: (context, snapshot) {
                            List<pharmappPharmacy?>? pharms = snapshot.data;

                            if (pharms != null && pharms.length != 0) {
                              return SizedBox(
                                  height: 200,
                                  child: PageView.builder(
                                    itemCount: pharms.length,
                                    controller:
                                        PageController(viewportFraction: 0.7),
                                    onPageChanged: (int index) =>
                                        setState(() => _indexPharm = index),
                                    itemBuilder: (_, j) {
                                      return Transform.scale(
                                        scale: j == _indexPharm ? 1 : 0.9,
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  Dimen.boxBorderRadius),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Image.network(
                                                'https://merzifon.bel.tr/wp-content/uploads/2018/02/eczane-logo-gorsel.png',
                                                width: 100,
                                                height: 100,
                                              ),
                                              Center(
                                                child: Text(
                                                  pharms[j]!.name,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/listProducts',
                                                          arguments: {
                                                            'pharm': pharms[j],
                                                          });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .list_alt_outlined,
                                                          color: AppColors
                                                              .titleText,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'List Products',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .buttonText,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: Dimen
                                                              .boxBorderRadius),
                                                      backgroundColor:
                                                          AppColors.button,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            } else if (pharms == null) {
                              return Text("Fetching");
                            } else {
                              return Text("There is no favourite pharmacy");
                            }
                          }),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Home',
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
            'Home',
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

  Future<dynamic> addAddressPopUp(
      BuildContext context, pharmappUser pUser, List<pharmappAddress?>? addrs) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<List<pharmappAddress>>(
              stream: DatabaseService_address(id: "", ids: []).allAddrs,
              builder: (context, snapshot) {
                List<pharmappAddress>? allAddrs = snapshot.data;
                return AlertDialog(
                  content: Stack(
                    children: <Widget>[
                      Form(
                        key: _formKeyPopUp,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                isDense: true,
                                isExpanded: true,
                                hint: Text("Select a City"),
                                items: allAddrs?.map((element) {
                                  return DropdownMenuItem(
                                    value: element.id,
                                    child: Text(element.city),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  _addAddress = val;
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
                                      onPressed: () async {
                                        if (_addAddress != null) {
                                          await DatabaseService(uid: pUser.id)
                                              .addAddress(_addAddress, addrs!);
                                          setState(() {
                                            _addAddress = null;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              color: AppColors.buttonText),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                Dimen.boxBorderRadius),
                                        backgroundColor: AppColors.button,
                                      ),
                                    ),
                                  )
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
        });
  }

  Future<dynamic>? ratePopUp(BuildContext context, String id, String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<pharmappPharmacy>(
              stream: DatabaseService_pharm(id: id, ids: []).pharmData,
              builder: (context, snapshot) {
                pharmappPharmacy? pharm = snapshot.data;

                if (pharm != null) {
                  List<dynamic>? rates = pharm.ratings;
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Form(
                          key: _formKeyRate,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 75,
                                width: 75,
                                child: Image.network(
                                  'http://www.aeo.org.tr/Helpers/DuyuruIcon.ashx?yayinyeri=sayfaicerik&Id=36690',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                name,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'How satisfied were you with your purchase?',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '1: Not at all \t 10: Very Satisfied',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
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
                                      rate = value;
                                      pre_rates = rates;
                                    });
                                  },
                                  onIncrement: (value) {
                                    setState(() {
                                      pre_rates = rates;
                                      rate = value;
                                    });
                                  },
                                  onDecrement: (value) {
                                    setState(() {
                                      pre_rates = rates;
                                      rate = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      pre_rates = rates;
                                      rate = value;
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
                                            pre_rates = rates;
                                            approved = true;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            'Give Rate',
                                            style: TextStyle(
                                                color: AppColors.buttonText),
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  Dimen.boxBorderRadius),
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
                } else {
                  return AlertDialog(
                      content: Stack(children: <Widget>[
                    Center(
                      child: Text("Fetching Data"),
                    )
                  ]));
                }
              });
        });
  }
}
