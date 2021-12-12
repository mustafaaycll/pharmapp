import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:collection/collection.dart';

class Address {
    const Address(this.name,this.icon);
    final String name;
    final Icon icon;
}

class Order {
    const Order(this.pharmacy,this.date,this.products, this.prices);
    final String pharmacy;
    final String date;
    final List<String> products;
    final List<double> prices;

}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int _index = 0;
  Address? selectedAdress;
  List<Address> adresses = <Address>[
    const Address('Sabanci University Campus', Icon(Icons.home_work, color: const Color(0xff44BBA4),)),
    const Address('Fatih Mah. Fatih Sok. No:11',Icon(Icons.home, color:  const Color(0xff44BBA4),)),
    const Address('19 Mayıs Mah. Oruç Sok. No:7',Icon(Icons.home, color:  const Color(0xff44BBA4),)),
    const Address('Kazım Karabekir Mah. Agah Sok. No:45',Icon(Icons.home, color:  const Color(0xff44BBA4),)),
  ];

  List<Order> orders = <Order>[
    const Order('Faruk Eczanesi', '05/03/2021',['Ortodontik Diş Fırçası', 'Apranax Fort Ağrı Kesici'], [57.0, 24.56]),
    const Order('Güneş Eczanesi', '04/01/2021', ['Listerine Ağız Bakım'], [33.49]),
    const Order('Parlak Eczanesi', '25/10/2020', ['BreatheRight Burun Bandı', 'Batticon Tentürdiyot'], [42.49, 11.90]),
    const Order('Tuzla Eczanesi', '17/08/2020', ['Diş Fırçası', 'Apranax Fort Ağrı Kesici', 'Cımbız', 'Sanitabant Yarabandı', 'Gazlı Bez'], [57.0, 24.56, 11.50, 3.40, 5.00]),
    const Order('Sevgi Eczanesi', '04/06/2020', ['Cold Away C', 'Arveles Ağrı Kesici'], [10.0, 7.96])
  ]; 
  
  List<String> favPharms = <String>['Faruk Eczanesi', 'Parlak Eczanesi'];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context); //use this to check if the user is logged in
    
    return Scaffold(
      appBar: AppBar(
        title: Text('PharMapp',
        style: TextStyle(
            color: AppColors.titleText,
            fontSize: 26
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButton<Address>(
                      borderRadius: Dimen.boxBorderRadius,
                      isExpanded: true,
                      isDense: false,
                      hint: Text("Select a Delivery Address"),
                      value: selectedAdress,
                      onChanged: (Address? Value){
                        setState(() {
                          selectedAdress = Value;
                        });
                      },
                      items: adresses.map((Address selectedAdress) {
                        return DropdownMenuItem<Address>(
                          value: selectedAdress,
                          child: Row(
                            children: <Widget>[
                              selectedAdress.icon,
                              SizedBox(width: 10),
                              Text(
                                selectedAdress.name,
                                style: TextStyle(color: AppColors.bodyText)
                              )
                            ],
                          ),
                        );
                      }).toList(),
                                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Add Address',
                          style: TextStyle(color: AppColors.buttonText),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: Dimen.boxBorderRadius
                      ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                  SizedBox(width:6),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'List Pharmacies',
                          style: TextStyle(color: AppColors.buttonText),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: Dimen.boxBorderRadius
                      ),
                        backgroundColor: AppColors.secondary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Previous Orders',
                style: TextStyle(
                  color: AppColors.bodyText,
                  fontSize: 26
                  ),
                  ),
              SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: orders.length,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index? 1 : 0.9,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              color: AppColors.secondary75percent,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(orders[i].pharmacy,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('${orders[i].date} - ${orders[i].prices.sum.toStringAsFixed(2)} TL',
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text("${orders[i].products.join('\n')}"),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text("${orders[i].prices.join('\n')}"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: OutlinedButton(
                                onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.repeat_outlined,
                                      color: AppColors.titleText,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      'Repeat',
                                      style: TextStyle(color: AppColors.buttonText,
                                                    fontSize: 15),
                                    ),
                                  ],
                                ),
                                style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius
                                ),
                                backgroundColor: AppColors.button,
                                )
                                
                              ),
                            )
                          ],
                          
                        ),
                        ),
                    );
                  },
                )
              ),
              SizedBox(height: 20),
              Text(
                'Favourite Pharmacies',
                style: TextStyle(
                  color: AppColors.bodyText,
                  fontSize: 26
                  ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: favPharms.length,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, j) {
                    return Transform.scale(
                      scale: j == _index? 1 : 0.9,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network('https://merzifon.bel.tr/wp-content/uploads/2018/02/eczane-logo-gorsel.png',
                            width: 100,
                            height: 100,),
                            Center(
                              child: Text(
                                favPharms[j],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: OutlinedButton(
                                onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.list_alt_outlined,
                                      color: AppColors.titleText,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      'List Products',
                                      style: TextStyle(color: AppColors.buttonText,
                                                    fontSize: 15),
                                    ),
                                  ],
                                ),
                                style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius
                                ),
                                backgroundColor: AppColors.button,
                                )
                                
                              ),
                            )
                          ],
                          
                        ),
                        ),
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
