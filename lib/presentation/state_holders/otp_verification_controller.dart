
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;

  String _accessToken = '';
  String get accessToken => _accessToken;



  Future<bool> getVerifyLogin(String email,String otp) async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.verifyLogin(email,otp));
    if(response.isSuccess && response.responseData['msg'] == 'success'){
      _accessToken = response.responseData['data'];
      _errorMessage = null;
      isSuccess = true;

    }else{
      _errorMessage =  response.errorMessage ?? 'An unknown error occurred';
    }
    _inProgress = false;
    update();
    return isSuccess;

  }

}