import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class DeleteWishListController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage = '';
  String ? get errorMessage => _errorMessage;
  
  
  Future<bool> deleteWishList(String productId) async{
    
    bool isSuccess = false;
    _inProgress = true;
    update();
    
    String ? token = AuthController.accessToken;
    if(token != null){
      final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
          url: Urls.deleteWishList(productId),
          token: token
      );
      if(response.isSuccess && response.responseData['msg'] == 'success'){
        _errorMessage = null;
        isSuccess = true;
      }else{
        _errorMessage = response.errorMessage ?? '';
        isSuccess = false;
      }
    }

    _inProgress = false;
    update();

    return isSuccess;

    
    
    
  }

}