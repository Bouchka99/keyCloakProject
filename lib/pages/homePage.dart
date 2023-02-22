import 'package:flutter/material.dart';
import 'package:keycloack_proj/flavor_config.dart';
import 'package:keycloack_proj/pages/actualityPage.dart';
import 'package:keycloack_proj/pages/drawer.dart';
import 'package:keycloack_proj/pages/loginPage.dart';
import 'package:keycloack_proj/pages/profilePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  FlavorConfig flavorConfig = FlavorConfig.getInstance();

  navigationBetweenPages(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  getBody() {
    if (currentIndex == 0)
      {
        ProfilePage.fromDrawer =false;
        return ProfilePage();
      }
    else if (currentIndex ==1)
      return ActualityPage();
    else
      showLogoutDialog(context);
    //return Container();

  }

  getTitle() {
    if (currentIndex == 0)
      return Text("Profile ${flavorConfig.variable}");
    else
      return Text("Actualités ${flavorConfig.variable}");

  }
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Etes vous sur de se déconnecter"),
        actions: [
          ListTile(
            title: Text("confirmer"),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginPage()), (Route<dynamic> route) => false);
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          iconSize: MediaQuery.of(context).size.height * 0.03,
          selectedIconTheme: IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          onTap: (index) {

            if (index == 2) {
              print("printtttttttttttt");
              showLogoutDialog(context);
            } else {
              navigationBetweenPages(index);
            }
          },
          backgroundColor: Colors.greenAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Profil",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.amp_stories), label: "Actualités"),
            BottomNavigationBarItem(
                icon: Icon(Icons.follow_the_signs_outlined),
                label: "Se déconnecter")
          ]),
      appBar: AppBar(
        title: getTitle(),
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: getBody(),
      drawer: DrawerScreen(),
    );
  }
}
