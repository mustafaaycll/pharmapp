import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';

class editDelAddrScreen extends StatefulWidget {
  const editDelAddrScreen({Key? key}) : super(key: key);

  @override
  _editDelAddrScreenState createState() => _editDelAddrScreenState();
}

class _editDelAddrScreenState extends State<editDelAddrScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<pharmappUser>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          pharmappUser? pUser = snapshot.data;

          if (pUser != null) {
            List<dynamic> user_addrs = pUser.addresses;
            return StreamBuilder<List<pharmappAddress?>>(
              stream: DatabaseService_address(id: "", ids: user_addrs).addrs,
              builder: (context, snapshot) {
                List<pharmappAddress?>? addrs = snapshot.data;

                if (addrs != null && addrs.length != 0) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Addresses',
                        style:
                            TextStyle(color: AppColors.titleText, fontSize: 26),
                      ),
                      centerTitle: true,
                      backgroundColor: AppColors.primary,
                      elevation: 0.0,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: addrs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {},
                              leading: Icon(
                                Icons.home,
                                color: const Color(0xff44BBA4),
                                size: 45,
                              ),
                              title: Text(addrs[index]!.city),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Color(0xffE13419),),
                                onPressed: () {
                                  DatabaseService(uid: pUser.id).removeAddress(addrs[index]!.id, addrs);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (addrs == null) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Addresses',
                        style:
                            TextStyle(color: AppColors.titleText, fontSize: 26),
                      ),
                      centerTitle: true,
                      backgroundColor: AppColors.primary,
                      elevation: 0.0,
                    ),
                    body: Center(
                      child: Text(
                        'Fetching Data',
                        style:
                            TextStyle(color: AppColors.bodyText, fontSize: 30),
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Addresses',
                        style:
                            TextStyle(color: AppColors.titleText, fontSize: 26),
                      ),
                      centerTitle: true,
                      backgroundColor: AppColors.primary,
                      elevation: 0.0,
                    ),
                    body: Center(
                      child: Text(
                        'No Address Stored',
                        style:
                            TextStyle(color: AppColors.bodyText, fontSize: 30),
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Favourite Pharmacies',
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
}
