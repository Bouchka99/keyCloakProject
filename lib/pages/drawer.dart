import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keycloack_proj/pages/loginPage.dart';
import 'package:keycloack_proj/pages/profilePage.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blueGrey,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/mahdi.jpg'),
                    ),
                  ),
                  title: Text(
                    "Bienvenu dans notre application test",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'IndieFlower',
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  leading: const Icon(Icons.account_box),
                  title: const Text('Voir profil'),
                  onTap: () {
                    ProfilePage.fromDrawer =true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                Divider(
                  height: Get.height * .01,
                  color: Colors.black,
                ),
                ListTile(
                  contentPadding:const EdgeInsets.symmetric(horizontal: 30.0),
                  leading: const Icon(Icons.follow_the_signs_outlined),
                  title: const Text('Déconnexion'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Etes vous sur de se déconnecter"),
                        actions: [
                          ListTile(
                            title: Text("confirmer"),
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (Route<dynamic> route) => false);
                            },
                            leading: Icon(Icons.check),
                          ),
                          ListTile(
                            title: Text("annuler"),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            leading: Icon(Icons.cancel),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
