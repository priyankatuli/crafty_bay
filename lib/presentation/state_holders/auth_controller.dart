import 'package:shared_preferences/shared_preferences.dart';

class AuthController{

  static String ? accessToken;

  //key
  final String _accessTokenKey = 'access-token';

Future<void> saveAccessToken(String token) async{
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  await sharedPreference.setString(_accessTokenKey, token); //kun key r against e value ke rakhbo
  accessToken = token;

}
  Future<String?> getAccessToken() async{ //key-value pairs
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final String ? token = sharedPreference.getString(_accessTokenKey);
    accessToken = token;
    return token;

  }

  bool isLoggedInUser(){
   //String ? token = await getAccessToken();
    return accessToken != null;
  }

  Future<void> clearUserData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }



 }