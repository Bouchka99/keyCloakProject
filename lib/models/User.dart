import 'dart:convert';


User UserJson(String str) =>
    User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());
class User {
  int? id;
  String? nom;
  String? prenom ;
  String? telephone;
  String email;
  String password;
  String? role;


  User({
    this.id,
     this.nom,  this.prenom,required this.email, this.telephone,required this.password, this.role
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    nom: json["nom"], id: json["id"],prenom: json["prenom"],
    email: json["email"], telephone: json["telephone"],password: json["password"],role: json["role"]
  );

  Map<String, dynamic> toJson() => {
    "nom": nom,
    'id': id,
    "prenom": prenom,
    "email" :email,
    "telephone": telephone,
    'password' :password,
    "role" :role
  };


}
class Users {

  List<User>? userList;

  Users({this.userList});

  factory Users.fromJSON(Map<dynamic, dynamic> json) {
    return Users(userList: parserecipes(json));
  }

  static List<User> parserecipes(doctorJSON) {
    var dList = doctorJSON['users'] as List;
    List<User> userList =
    dList.map((data) => User.fromJson(data)).toList();
    return userList;
  }
}
