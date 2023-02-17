import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:keycloack_proj/models/UserInfo.dart';
import 'package:keycloack_proj/services/secureStorage.dart';
import 'dart:developer' as dev;

import 'package:keycloack_proj/views/snackBarView.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userToken = "";
  UserInfo? userInfo;

  Future<void> GettingUserInfoUsingDio() async {
    Dio dio = Dio();
    try {
      dio.options.headers = {"Authorization": "Bearer $userToken"};
      Response response = await dio.get(
        "http://10.0.2.2:8080/realms/demo/protocol/openid-connect/userinfo",
      );
      if (response.statusCode == 200) {
        print("Getting user info successfully");
        print("response.data : ${response.data}");
        print("type de response.data : ${response.data.runtimeType}");
        Map<String, dynamic> jsonData =
            Map<String, dynamic>.from(response.data);
        //Map<String, dynamic> decodedJson = jsonDecode(response.data);
        print(response.data['sub']);

        print("jsonData : $jsonData");

        print("********************* ${jsonData['name']}");
        userInfo = UserInfo.fromJson(jsonData);

        print("-------------name user info ${userInfo!.name}");
        //Map<String,dynamic> jsonData = Map<String,dynamic>.from(response.data);
        //print("type de jsonData : ${jsonData.runtimeType}");

      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          //showSnackBar("Dépassement du délais de connexion (connection time out)");
          SnackBarView().showSnackBarUsingGetX(
              title: "Erreur",
              message:
                  "Dépassement du délais de connexion (connection time out)",
              color: Colors.red,
              icon: Icons.error);
          break;
        case DioErrorType.receiveTimeout:
          //showSnackBar("Dépassement du délais de réponse (receive time out)");
          SnackBarView().showSnackBarUsingGetX(
              title: "Erreur",
              message: "Dépassement du délais de réponse (receive time out)",
              color: Colors.red,
              icon: Icons.error);
          break;
        case DioErrorType.sendTimeout:
          //showSnackBar("Dépassement du délais d'envoi (send time out)");
          SnackBarView().showSnackBarUsingGetX(
              title: "Erreur",
              message: "Dépassement du délais d'envoi (send time out)",
              color: Colors.red,
              icon: Icons.error);
          break;
        case DioErrorType.response:
          //showSnackBar("Erreur dans la réponse qui est invalide (status  différent de 200)");
          SnackBarView().showSnackBarUsingGetX(
              title: "Erreur",
              message:
                  "Erreur dans la réponse qui est invalide (status  différent de 200)",
              color: Colors.red,
              icon: Icons.error);
          break;
        default:
          //showSnackBar("Une erreur s'est produite");
          SnackBarView().showSnackBarUsingGetX(
              title: "Erreur",
              message: "Une erreur s'est produite",
              color: Colors.red,
              icon: Icons.error);
      }
    }
  }

  Future<void> gettingTokenFromSecureStorage() async {
    print("entreeeeeeeeeeeeeeeeeeeeeee gettingTokenFromSecureStorage");
    userToken = await SecureStorageService.getToken();
    if (userToken == null) {
      print("userToken null");
      return;
    }
    await GettingUserInfoUsingDio();
    setState(() {});
  }

  @override
  void initState() {
    gettingTokenFromSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          // height: Get.height ,
          width: Get.width * 0.9,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: const CircleAvatar(
                      radius: 75.0,
                      backgroundImage: AssetImage(
                        "assets/mahdi.jpg",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .1,
                  ),
                  Expanded(
                    flex: 3,
                    child: Material(
                      elevation: 20.0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bienvenu monsieur",
                              style: TextStyle(
                                  fontFamily: "IndieFlower",
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              userInfo == null ? "" : userInfo!.given_name!,
                              style: const TextStyle(
                                fontSize: 25.0, fontFamily: "IndieFlower",
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              userInfo == null ? "" : userInfo!.family_name!,
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: "IndieFlower"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                height: Get.height * 0.1,
                color: Colors.black,
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Material(
                elevation: 20.0,
                child: Container(
                  height: Get.height * .9,
                  padding: const EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 0.0),
                  color: Colors.grey[200],
                  child: ListView(scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Voici quelques coordonnées à propos de vous",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "IndieFlower",
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Card(
                        child: ListTile(
                          leading:  const Text("Pseudo : ",style: TextStyle(fontSize: 14.0),),
                          title: Text(
                            userInfo == null
                                ? ""
                                : userInfo!.preferred_username!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      /*Row(
                        children: [
                          const Text("Pseudo : "),
                          Text(
                            userInfo == null
                                ? ""
                                : userInfo!.preferred_username!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Card(
                        child: ListTile(
                          leading:  const Text("Sub : "),
                          title: Text(
                            userInfo == null ? "" : userInfo!.sub!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      /*Row(
                        children: [
                          const Text("Sub : "),
                          Expanded(
                            child: Text(
                              userInfo == null ? "" : userInfo!.sub!,
                              style: const TextStyle(
                                fontSize: 20.0, fontFamily: "IndieFlower",
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Card(
                        child: ListTile(
                          leading:  const Text("Nom : "),
                          title:Text(
                            userInfo == null ? "" : userInfo!.given_name!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      ),
                      /*Row(
                        children: [
                          const Text("Nom : "),
                          Text(
                            userInfo == null ? "" : userInfo!.given_name!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Card(
                        child: ListTile(
                            leading:  const Text("Prénom : "),
                            title:Text(
                              userInfo == null ? "" : userInfo!.family_name!,
                              style: const TextStyle(
                                fontSize: 20.0, fontFamily: "IndieFlower",
                                //fontWeight: FontWeight.bold
                              ),
                            )                        ),
                      ),
                      /*Row(
                        children: [
                          const Text("Prénom : "),
                          Text(
                            userInfo == null ? "" : userInfo!.family_name!,
                            style: const TextStyle(
                              fontSize: 20.0, fontFamily: "IndieFlower",
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Card(
                        child: ListTile(
                            leading:   const Text("Email : "),
                            title:userInfo != null
                                ? userInfo!.email_verified!
                                ? Text(
                                  userInfo!.email! + " ( vérifié ) ",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "IndieFlower",
                                    //fontWeight: FontWeight.bold
                                  ),
                                )
                                : Text(
                                  userInfo!.email! + " ( non vérifié ) ",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "IndieFlower",
                                    //fontWeight: FontWeight.bold
                                  ),
                                )
                                : Text(""),                ),
                      ),
                      /*Row(
                        children: [
                          const Text("Email : "),
                          userInfo != null
                              ? userInfo!.email_verified!
                                  ? Expanded(
                                      child: Text(
                                        userInfo!.email! + " ( vérifié ) ",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "IndieFlower",
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Text(
                                        userInfo!.email! + " ( non vérifié ) ",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "IndieFlower",
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                              : Text(""),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
