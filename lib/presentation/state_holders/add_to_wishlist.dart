import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_list_item.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wishlist_controller.dart';
import 'package:get/get.dart';

class AddToWishList extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage = '';
  String ? get errorMessage => _errorMessage;

 List<int> _wishListProductId = [];

 bool _isProductAdded = false;
 bool get isProductAdded => _isProductAdded;


void isAddedWishList(int productID){
  bool isContain = Get.find<WishlistController>().wishList!.any((product) => product.productId == productID);
  if(isContain){
    _isProductAdded = true;
  }else{
    _isProductAdded = false;
  }
  update(); // notify the UI to rebuild the screen
}

  Future<bool> createWishList(int productId) async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    String ? token = await AuthController.accessToken;
    if(token != null){
      final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
          url: Urls.createWishList(productId),
          token: token
      );
      if(response.isSuccess && response.responseData['msg'] == 'success'){
        _wishListProductId.add(productId);
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