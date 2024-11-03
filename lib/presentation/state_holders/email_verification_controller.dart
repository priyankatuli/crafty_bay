
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController{
  
  bool _inProgress = false;
  bool get inProgress{
    return _inProgress;
  }
  
  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;
  
  
  Future<bool> getEmailVerification(String email) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.userLogin(email));
    if(response.isSuccess && response.responseData['msg'] == 'success'){
      _errorMessage = null;
      isSuccess = true;

    }else{
      _errorMessage = response.errorMessage ?? '';
    }
    
    _inProgress = false;
    update();
    return isSuccess;
  }
  
  
}