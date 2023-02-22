import 'dart:convert';


// from a string JSON => object JSON => object UserInfo
UserInfo UserInfoFromJson(String str){
  return UserInfo.fromJson(json.decode(str));
}

// from an object UserInfo => object JSON => String JSON
String UserInfoToJson(UserInfo userInfo){
  return json.encode(userInfo.toJson());
}



class UserInfo {
  String sub; //id
  bool email_verified;
  String name; //nom prenom
  String preferred_username; //pseudo
  String given_name; //prenom
  String family_name; //nom
  String email; // email

  UserInfo(
      {required this.sub,
      required this.email,
      required this.name,
      required this.email_verified,
      required this.family_name,
      required this.given_name,
      required this.preferred_username});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
     UserInfo(
        email: json["email"]??"",
        email_verified: json["email_verified"]??"",
        family_name: json["family_name"]??"",
        given_name: json["given_name"]??"",
        name: json["name"]??"",
        preferred_username: json["preferred_username"]??"",
        sub: json["sub"]??"");


  Map<String, dynamic> toJson() {
    return {
      "sub": sub,
      "email_verified": email_verified,
      "name": name,
      "preferred_username": preferred_username,
      "given_name": given_name,
      "family_name": family_name,
      "email": email
    };
  }
}
