import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:keycloack_proj/pages/SignUpPage.dart';
import 'package:keycloack_proj/pages/homePage.dart';

import 'package:keycloack_proj/pages/profilePage.dart';
import 'package:keycloack_proj/services/secureStorage.dart';
import 'package:keycloack_proj/views/snackBarView.dart';
import 'dart:developer' as dev;
//import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:keycloack_proj/flavor_config.dart';



import '../models/User.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///  attributs
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscure_password = true;

  /// show or not password
  void show_password(){
    setState(() {
      obscure_password =!obscure_password;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  User? userLoggedIn;

  User? userConnected;
  int? idUserConnected;
  String? tokenUser;

  //basic snackBAR
  showSnackBar(String messageToDisplay) {
    final snackBar = SnackBar(padding: const EdgeInsets.fromLTRB(55.0, 0.0, 0.0, 0.0),
      backgroundColor: Colors.red[300],
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      width: Get.width * 0.8,
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
      content: Text(

        messageToDisplay,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          ///
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //snackBar using GetX
  void showSnackBarUsingGetX({required String title, required String message, required Color color, required IconData icon}){
    Get.snackbar(
        title,
        message,
        duration: const Duration(seconds: 2),
        maxWidth: Get.width * .6,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: color,
        colorText: Colors.white,
        icon:  Icon(
          icon,
          color: Colors.white,
        ));
  }

  // service de login
  Future<void> connexionUsingDio() async {
    print("entreeeeee");
    Dio dio = Dio();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        dio.options.contentType = Headers.formUrlEncodedContentType;
        Response response = await dio.post(
            "http://192.168.1.13:8080/realms/demo/protocol/openid-connect/token",
            data: {
              "username": _email,
              "password": _password,
              "grant_type": "password",
              "client_id": "test-client",
              "scope" : "openid"
            });
        if (response.statusCode == 200) {
          print("Login successfully");
          //showSnackBarUsingGetX(title: "Succès", message: "Vous êtes connecté", color: Colors.green, icon: Icons.gpp_good);
          SnackBarView().showSnackBarUsingGetX(title: "Succès", message: "Vous êtes connecté", color: Colors.green, icon: Icons.gpp_good);
          print("response.data : ${response.data}");
          print("type de response.data : ${response.data.runtimeType}");
          //Map<String,dynamic> jsonData = Map<String,dynamic>.from(response.data);
          //print("type de jsonData : ${jsonData.runtimeType}");
          dev.log("logueuuuuuuuuuuuuuuuur : ${response.data['access_token'].toString().length.toString()}");
          dev.log("json data : ${response.data['access_token']}");
          SecureStorageService.userToken=response.data['access_token'];
          await SecureStorageService.setToken(SecureStorageService.userToken);
          dev.log("*********************** ${SecureStorageService.userToken}");

          //Using arguments just to try passing data from LoginPage to HomePage, the arguments are stocked in testMap keep a look on HomePage
          Get.off(() => HomePage(),arguments: {
            "name" : "testName",
            "age" : 15
          });
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        }
      } on DioError catch (e) {
        switch(e.type){
          case DioErrorType.connectTimeout :
            //showSnackBar("Dépassement du délais de connexion (connection time out)");
            SnackBarView().showSnackBarUsingGetX(title: "Erreur", message: "Dépassement du délais de connexion (connection time out)", color: Colors.red, icon: Icons.error);
            break;
          case DioErrorType.receiveTimeout :
            //showSnackBar("Dépassement du délais de réponse (receive time out)");
            SnackBarView().showSnackBarUsingGetX(title: "Erreur", message: "Dépassement du délais de réponse (receive time out)", color: Colors.red, icon: Icons.error);
            break;
          case DioErrorType.sendTimeout : 
            //showSnackBar("Dépassement du délais d'envoi (send time out)");
            SnackBarView().showSnackBarUsingGetX(title: "Erreur", message: "Dépassement du délais d'envoi (send time out)", color: Colors.red, icon: Icons.error);
            break;
          case DioErrorType.response :
            //showSnackBar("Erreur dans la réponse qui est invalide (status  différent de 200)");
            SnackBarView().showSnackBarUsingGetX(title: "Erreur", message: "Erreur dans la réponse qui est invalide (status  différent de 200)", color: Colors.red, icon: Icons.error);
            break;
          default :
            //showSnackBar("Une erreur s'est produite");
            SnackBarView().showSnackBarUsingGetX(title: "Erreur", message: "Une erreur s'est produite", color: Colors.red, icon: Icons.error);
        }

      }
    } else {
      //showSnackBar("Veuiller remplir tous les champs correctement!");
      showSnackBarUsingGetX(title: "Attention", message: "Veuillez remplir tous les champs correctement", color: Colors.red, icon: Icons.error_outline);
    }

  }

  @override
  Widget build(BuildContext context) {
    // FlavorConfig flavorConfig = FlavorConfig(
    //   name: "DEVELOP",
    //   color: Colors.red,
    //   location: BannerLocation.bottomStart,
    //   variables: {
    //     "counter": 5,
    //     "baseUrl": "https://www.example.com",
    //   },
    // );

    //final myVariable = BuildConfig.FLAVOR == "deve" ? BuildConfig.var1 : (BuildConfig.FLAVOR == "qa" ? BuildConfig.var2 : null);
    FlavorConfig flavorConfig = FlavorConfig.getInstance();


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title:  Text("Connexion ${flavorConfig.variable}"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              margin:  EdgeInsets.fromLTRB(20.0, Get.height*.05, 20.0, 0.0),
              height: Get.height *0.9,
              width: Get.width*0.9,
              color: Colors.grey[200],
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        scale: 3.5,
                        height: 45,
                        opacity: const AlwaysStoppedAnimation(0.5),
                      ),
                      Image.asset(
                        "assets/logo.png",
                        height: 100,
                        width: 100,
                      ),
                      TextFormField(
                        //controller: TextEditingController(text: _email),
                        onChanged: (val) {
                          //_email = val;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email)),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Veuillez saisir votre email"),
                          EmailValidator(errorText: "Veuillez saisir un email valide")
                        ]),
                        onSaved: (value) => _email = value,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //controller: TextEditingController(text: _password),
                        onChanged: (val) {
                          //user!.password = val;
                        },
                        decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            icon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: obscure_password  ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: (){
                                show_password();
                              },
                            )),
                        validator: RequiredValidator(
                          errorText: "Veuillez saisir votre mot de passe"
                        ),
                        onSaved: (value) => _password = value,
                        obscureText: obscure_password,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 140.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[700]),
                                child: const Text('Se connecter'),
                                onPressed: () async{
                                  connexionUsingDio();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 140.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[700]),
                                child: const Text('Non inscrit !'),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()));
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Person extends StatelessWidget {
  const Person({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class testClass extends StatefulWidget {
  const testClass({Key? key}) : super(key: key);

  @override
  State<testClass> createState() => _testClassState();
}

class _testClassState extends State<testClass> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


