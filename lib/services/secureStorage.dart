import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static  String userToken = "userToken";

  static Future<void> setToken(String nouveauToken) async{
    await secureStorage.write(key: userToken, value: nouveauToken);
  }

  static Future <String> getToken() async {
     var auxiliaire =await secureStorage.read(key: userToken);
     return auxiliaire!;
  }


}