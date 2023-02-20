
import 'package:flutter/material.dart';
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
                    "Bienvenu dans notre cabinet",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  leading : const Icon( Icons.calendar_today),
                  title: const Text('Voir profil'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                  leading : const Icon( Icons.calendar_today),
                  title: const Text('Déconnexion'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProfilePage()),
                    );
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}
