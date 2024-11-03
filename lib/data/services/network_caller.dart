import 'dart:convert';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:get/get.dart' as getx; //named input
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../presentation/state_holders/auth_controller.dart';

class NetworkCaller {

  final Logger logger;
  final AuthController authController;

  NetworkCaller({required this.logger,required this.authController}); // to get logger instance from this line

 Future<NetworkResponse> getRequest({required String url,String ? token}) async{

   try{
     Uri uri = Uri.parse(url);
     _requestLog(url, {}, {}, '');
     final response = await get(uri, headers: {
       'token': '${token ?? AuthController.accessToken}',
     });
     if(response.statusCode == 200){
       _responseLog(url, response.statusCode, response.headers, response.body, true);
       final decodeBody = jsonDecode(response.body);
       return NetworkResponse(
           statusCode: response.statusCode,
           isSuccess: true,
           responseData: decodeBody,
       );
     }
     else{
       _responseLog(url, response.statusCode, response.headers, response.body, false);
       if(response.statusCode == 401){
         _moveToLogin();
       }
       return NetworkResponse(
           statusCode: response.statusCode,
           isSuccess: false,
       );
     }
   }catch(e){
     _responseLog(url, -1, {} ,null, false ,e );
    return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
    );
   }

 }

 Future<NetworkResponse> postRequest({required String url, Map<String, dynamic> ? body, String? token}) async{

   try{
     Uri uri = Uri.parse(url);
     _requestLog(url, {}, body ?? {}, AuthController.accessToken ?? '');
     final response = await post(uri, headers: {
       'token': '${AuthController.accessToken}',
        'content-type' : 'application/json'
     }, body: jsonEncode(body));

     if(response.statusCode == 200){
       _responseLog(url, response.statusCode, response.headers, response.body, true);
       final decodeBody = jsonDecode(response.body);
       return NetworkResponse(
         statusCode: response.statusCode,
         isSuccess: true,
         responseData: decodeBody,
       );
     }
     else{
       _responseLog(url, response.statusCode, response.headers, response.body, false);
       if(response.statusCode == 401){
         _moveToLogin();
       }
       return NetworkResponse(
         statusCode: response.statusCode,
         isSuccess: false,
       );
     }
   }catch(e){
     _responseLog(url, -1, {}, body, false);
     return NetworkResponse(
       statusCode: -1,
       isSuccess: false,
       errorMessage: e.toString(),
     );
   }

 }

 void _requestLog(String url,Map<String,dynamic> params,Map<String,dynamic>body,String token){
   logger.i('''
     URL : $url,
     Params : $params,
     Body : $body,
     Token : $token
    ''');
 }

 void _responseLog(String url,int statusCode,
     Map<String,dynamic> headers , dynamic responseBody,bool isSuccessful,[dynamic error]){

   String message = '''
   URL : $url,
   StatusCode : $statusCode,
   Headers : $headers,
   Response Body : $responseBody, 
   Error : $error
   ''';
   if(isSuccessful){
     logger.i(message); //info
   }else{
     logger.e(message); //error type r message dekhabe
   }
 }

 Future<void> _moveToLogin() async{

      await authController.clearUserData();
      getx.Get.to(() => EmailVerificationScreen());
 }



}