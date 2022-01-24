// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharm_app/models/bookmarks/bookmarks.dart';
import 'package:pharm_app/models/comments/comments.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/products/products.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class managePharmScreen extends StatefulWidget {
  const managePharmScreen({ Key? key }) : super(key: key);

  @override
  _managePharmScreenState createState() => _managePharmScreenState();
}

class _managePharmScreenState extends State<managePharmScreen> {

  final _formKeyPriceChange = GlobalKey<FormState>();
  
  
  final _formKeyNewProduct = GlobalKey<FormState>();
  String? cat = "";
  String? productName = "";
  String? lira = "";
  String? kurus = "";
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  static final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);

  void _setImage(XFile? file) {
    _image = file;
    imageNotifier.value = _image;
    imageNotifier.notifyListeners();
  }


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final user = Provider.of<User?>(context);
    pharmappUser? pUser = arguments['user'];
    return StreamBuilder<pharmappPharmacy>(
      stream: DatabaseService_pharm(id: pUser!.ownership, ids: []).pharmData,
      builder: (context, snapshot) {
        pharmappPharmacy? pharm = snapshot.data;
        if (pharm != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'My Pharmacy',
                  style: TextStyle(color: AppColors.titleText, fontSize: 26),
                ),
                centerTitle: true,
                backgroundColor: AppColors.primary,
                elevation: 0.0,
              ),
              body: Padding(
                padding: EdgeInsets.all(8),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              createProduct(context, pharm);
                            },
                            child: Text("Sell New Item", style: TextStyle(color: AppColors.titleText),),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius),
                              backgroundColor: AppColors.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<List<pharmappProduct?>>(
                      stream: DatabaseService_product(id: "", ids: pharm.products).products,
                      builder: (context, snapshot){
                        List<pharmappProduct?>? products = snapshot.data;
                        return StreamBuilder<List<pharmappComment?>>(
                          stream: DatabaseService_comment(id: "", ids: pharm.comments).comments,
                          builder: (context, snapshot) {
                            List<pharmappComment?>? comments = snapshot.data;
                            return Expanded(
                              child: PageView(
                                controller: PageController(),
                                children: [
                                  productList(products, pUser, pharm),
                                  commentList(comments)
                                ]
                              ),
                            );
                          },
                        );
                      }
                    ),
                  ],
                ),
              ),
            );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'My Pharmacy',
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
      },
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

  Widget productList(List<pharmappProduct?>? products, pharmappUser pUser, pharmappPharmacy pharm) {
    if (products!.isEmpty) {
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
              Text("Sorry, there is no product",),
            ],
          ),
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
    List<pharmappProduct?> categorizedProducts = products.where((element) => element!.category == cat).toList();
    return StreamBuilder<List<pharmappBookmark?>>(
      stream: DatabaseService_bookmark(id: "", ids: pUser.bookmarks).bookmarks,
      builder: (context, snapshot) {
        List<pharmappBookmark?>? bookmarks = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categorizedProducts.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () async {
                },
                leading: SizedBox(
                    height: 75,
                    width: 75,
                    child: Image.network(categorizedProducts[index]!.url)
                ),
                title: Text(categorizedProducts[index]!.name),
                subtitle: Text('${categorizedProducts[index]!.price} ₺'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await deleteProductPopUp(context, categorizedProducts[index]!, pharm);
                      },
                      icon: Icon(Icons.remove_circle_outline, color: Color(0xffE13419),)),
                    IconButton(
                      onPressed: () async {
                        await changePricePopUp(context,categorizedProducts[index]!);
                      },
                      icon: Icon(Icons.attach_money, color: AppColors.button,))
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
  Widget commentList(List<pharmappComment?>? comments) {
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
            comments!.isEmpty ?
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

  Future<dynamic> createProduct(BuildContext context, pharmappPharmacy? pharm) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            children: <Widget>[
              ValueListenableBuilder<XFile?>(
                valueListenable: imageNotifier,
                builder: (context, file, __) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKeyNewProduct,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 180,
                            width: 180,
                            child: Center(
                              child: file != null ? Image.file(File(file.path)) : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_outlined),
                                  Text("No photo set"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("What is the product name?"),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null)
                                      return "You must type a name";
                                    else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return "You must type a name";
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Type Product Name',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.secondary50percent,
                                        ),
                                        borderRadius: Dimen.boxBorderRadius,
                                      )),
                                  onSaved: (value) {
                                    if (value != null) {
                                      productName = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text("What category it belongs to?"),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "You must select a category";
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  isDense: true,
                                  hint: Text("Select a Category"),
                                  items: ["Painkiller", "Dental Care", "Personal Care", "Supplementary"].map((element) {
                                    return DropdownMenuItem(
                                      value: element,
                                      child: Text(element),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {
                                    setState(() {
                                      cat = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondary50percent,
                                      ),
                                      borderRadius: Dimen.boxBorderRadius,
                                    )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text("What is the price?"),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null)
                                      return "Enter price";
                                    else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return "Enter price";
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Lira',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.secondary50percent,
                                        ),
                                        borderRadius: Dimen.boxBorderRadius,
                                      )),
                                  onSaved: (value) {
                                    if (value != null) {
                                      lira = value;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 4,),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null)
                                      return "Enter price";
                                    else {
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty) {
                                        return "Enter price";
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Kurus',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.secondary50percent,
                                        ),
                                        borderRadius: Dimen.boxBorderRadius,
                                      )),
                                  onSaved: (value) {
                                    if (value != null) {
                                      kurus = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          file == null ? Text("Choose an Image") : Text("Want to remove?"),
                          SizedBox(height: 8,),
                          file != null ?
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    _setImage(null);
                                  },
                                  child: Text("Remove",style: TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            Dimen.boxBorderRadius),
                                    backgroundColor: Color(0xffE13419),
                                  ),
                                ),
                              ),
                            ],
                          ) :
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    await pickImage();
                                  },
                                  child: Text("Choose",style: TextStyle(color: AppColors.buttonText)),
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
                          SizedBox(height: 16,),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (_formKeyNewProduct.currentState!.validate()) {
                                      if (_image != null) {
                                        _formKeyNewProduct.currentState!.save();
                                        await AuthService().uploadImageToFirebaseThenAddProductToFirestoreAndPharm(pharm, file, cat, productName, cleanPrice(lira)+'.'+cleanPrice(kurus));
                                        _setImage(null);
                                        Navigator.pop(context);
                                      }
                                      else {
                                        imageWarningPopUp(context);
                                      }
                                    }
                                  },
                                  child: Text("Add",style: TextStyle(color: AppColors.buttonText)),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.secondary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );},
              ),
            ],
          ),
        );
      }
    );
  }

  Future<dynamic> imageWarningPopUp(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.titleText,
          content: Stack(
            children: <Widget>[
              Form(
                key: null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            'Choose a picture!',
                            textAlign: TextAlign.center,
                          )
                      )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'OK',
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
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }


  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    _setImage(_image);
  }

  String cleanPrice(String? number) {
    String newNum = "";
    for (var i = 0; i < number!.length; i++) {
      if (number[i] != ' ' && number[i] != '-' && number[i] != '.' && number[i] != ',') {
        newNum += number[i];
      }
    }
    return newNum;
  }

  Future<dynamic> changePricePopUp(BuildContext context, pharmappProduct? product) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: _formKeyPriceChange,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
              
                      children: [
                        SizedBox(height: 8,),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(product!.url),
                        ),
                        SizedBox(height: 8,),
                        SizedBox(height: 8,),
                        Text("What is the new price for\n${product.name}?\n\nprevious price: ${product.price.toStringAsFixed(2)}₺", textAlign: TextAlign.center,),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null)
                                    return "Enter price";
                                  else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return "Enter price";
                                    }
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Lira',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondary50percent,
                                      ),
                                      borderRadius: Dimen.boxBorderRadius,
                                    )),
                                onSaved: (value) {
                                  if (value != null) {
                                    lira = value;
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null)
                                    return "Enter price";
                                  else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return "Enter price";
                                    }
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Kurus',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondary50percent,
                                      ),
                                      borderRadius: Dimen.boxBorderRadius,
                                    )),
                                onSaved: (value) {
                                  if (value != null) {
                                    kurus = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () async {
                                  if (_formKeyPriceChange.currentState!.validate()) {
                                    _formKeyPriceChange.currentState!.save();
                                    await DatabaseService_product(id: product.id, ids: []).updatePrice(cleanPrice(lira)+'.'+cleanPrice(kurus));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("Update",style: TextStyle(color: AppColors.buttonText)),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          Dimen.boxBorderRadius),
                                  backgroundColor: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Future<dynamic> deleteProductPopUp(BuildContext context, pharmappProduct? product, pharmappPharmacy? pharm) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: null,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8,),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(product!.url),
                        ),
                        SizedBox(height: 8,),
                        SizedBox(height: 8,),
                        Text("You are about to delete\n${product.name}\n\nDo you want to continue?", textAlign: TextAlign.center,),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Cancel',
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
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await DatabaseService_pharm(id: pharm!.id, ids: []).removeProduct(pharm.products, product.id);
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Delete',
                                    style:
                                        TextStyle(color: AppColors.buttonText),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: Dimen.boxBorderRadius),
                                  backgroundColor: Color(0xffE13419),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  )
                )
              )
            ]
          )
        );
      }
    );
  }
}