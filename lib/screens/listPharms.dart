import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';

class listPharmsScreen extends StatefulWidget {
  const listPharmsScreen({Key? key}) : super(key: key);

  @override
  _listPharmsScreenState createState() => _listPharmsScreenState();
}

class _listPharmsScreenState extends State<listPharmsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final user = Provider.of<User?>(context);
    return StreamBuilder<pharmappUser>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          pharmappUser? pUser = snapshot.data;

          if (pUser != null) {
            return StreamBuilder<List<pharmappPharmacy?>>(
                stream: DatabaseService_pharm(id: arguments['aid'], ids: [])
                    .pharmsByAddr,
                builder: (context, snapshot) {
                  List<pharmappPharmacy?>? pharms = snapshot.data;

                  if (pharms != null && pharms.length != 0) {
                    return StreamBuilder<List<pharmappPharmacy?>>(
                        stream:
                            DatabaseService_pharm(id: "", ids: pUser.fav_pharms)
                                .pharms,
                        builder: (context, snapshot) {
                          List<pharmappPharmacy?>? favPharms = snapshot.data;
                          return Scaffold(
                            appBar: AppBar(
                              title: Text(
                                'Pharmacies',
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
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: pharms.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/listProducts',
                                            arguments: {
                                              'pharm': pharms[index],
                                            });
                                      },
                                      leading: Image.network(
                                          'http://www.aeo.org.tr/Helpers/DuyuruIcon.ashx?yayinyeri=sayfaicerik&Id=36690'),
                                      title: Text(pharms[index]!.name),
                                      subtitle: Text(
                                          'Rating: ${pharms[index]!.ratings.reduce((a, b) => a + b) / pharms.length}'),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color: DatabaseService(uid: user.uid)
                                                  .favPharmExists(
                                                      pharms[index]!.id,
                                                      pUser.fav_pharms)
                                              ? Color(0xffffa200)
                                              : Color(0xff969493),
                                        ),
                                        onPressed: () {
                                          if (!DatabaseService(uid: user.uid)
                                              .favPharmExists(pharms[index]!.id,
                                                  pUser.fav_pharms)) {
                                            DatabaseService(uid: pUser.id)
                                                .addFavPharm(pharms[index]!.id,
                                                    pUser.fav_pharms);
                                          } else {
                                            DatabaseService(uid: pUser.id)
                                                .removeFavPharm(
                                                    pharms[index]!.id,
                                                    favPharms!);
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        });
                  } else if (pharms == null) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Pharmacies',
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
                          'Pharmacies',
                          style: TextStyle(
                              color: AppColors.titleText, fontSize: 26),
                        ),
                        centerTitle: true,
                        backgroundColor: AppColors.primary,
                        elevation: 0.0,
                      ),
                      body: Center(
                        child: Text(
                          'No Pharmacy Serving In This Area',
                          style: TextStyle(
                              color: AppColors.bodyText, fontSize: 15),
                        ),
                      ),
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
}
