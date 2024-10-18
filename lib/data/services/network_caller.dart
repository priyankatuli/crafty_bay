import 'dart:convert';
import 'package:ecommerce_project/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {

  final Logger logger;

  NetworkCaller({required this.logger}); // to get logger instance from this line

 Future<NetworkResponse> getRequest({required String url,String ? token}) async{

   try{
     Uri uri = Uri.parse(url);
     _requestLog(url, {}, {}, '');
     final response = await get(uri, headers: {
       'token': '$token',
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

 Future<NetworkResponse> postRequest({required String url, Map<String, dynamic> ? body}) async{

   try{
     Uri uri = Uri.parse(url);
     _requestLog(url, {}, body ?? {}, '');
     final response = await post(uri, headers: {
       'token': '',
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

}