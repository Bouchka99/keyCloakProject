import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:keycloack_proj/flavor_config.dart';
import 'package:keycloack_proj/pages/actualityPage.dart';
import 'package:keycloack_proj/pages/loginPage.dart';
import 'package:keycloack_proj/pages/splashPage.dart';



void mainCommon() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/" :  (context) => SplashPage(),
        "/home" : (context) => MyHomePage(title: "KeyCloackProject")
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ActualityPage();
  }
}
