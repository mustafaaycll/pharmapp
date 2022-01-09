import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';

class editFavPharmScreen extends StatefulWidget {
  const editFavPharmScreen({Key? key}) : super(key: key);

  @override
  _editFavPharmScreenState createState() => _editFavPharmScreenState();
}

class _editFavPharmScreenState extends State<editFavPharmScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<pharmappUser>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          pharmappUser? pUser = snapshot.data;

          if (pUser != null) {
            List<dynamic> favPharms = pUser.fav_pharms;
            return StreamBuilder<List<pharmappPharmacy?>>(
                stream: DatabaseService_pharm(id: "", ids: favPharms).pharms,
                builder: (context, snapshot) {
                  List<pharmappPharmacy?>? pharms = snapshot.data;

                  if (pharms != null && pharms.length != 0) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Favourite Pharmacies',
                          style: TextStyle(
                              color: AppColors.titleText, fontSize: 26),
                        ),
                        centerTitle: true,
                        backgroundColor: AppColors.primary,
                        elevation: 0.0,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: pharms.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {},
                                leading: Image.network(
                                    'http://www.aeo.org.tr/Helpers/DuyuruIcon.ashx?yayinyeri=sayfaicerik&Id=36690'),
                                title: Text(pharms[index]!.name),
                                subtitle: Text(
                                    'Rating: ${pharms[index]!.ratings.reduce((a, b) => a + b) / pharms.length}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    DatabaseService(uid: pUser.id)
                                        .removeFavPharm(
                                            pharms[index]!.id, pharms);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (pharms == null) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Favourite Pharmacies',
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
                              color: AppColors.bodyText, fontSize: 30),
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Favourite Pharmacies',
                          style: TextStyle(
                              color: AppColors.titleText, fontSize: 26),
                        ),
                        centerTitle: true,
                        backgroundColor: AppColors.primary,
                        elevation: 0.0,
                      ),
                      body: Center(
                        child: Text(
                          'No Favourite Pharmacy',
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
