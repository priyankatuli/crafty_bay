import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;

  List<CartItemModel> _cart = [];
  List<CartItemModel> get cart => _cart;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;
//getCartList
  Future<bool> getCartList() async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final String ? token = await AuthController.accessToken;
   if(token != null) {
     final NetworkResponse response = await Get.find<NetworkCaller>()
         .getRequest(
         url: Urls.getCartList,
         token: token
     );
     if (response.isSuccess && response.responseData['msg'] == 'success') {
       _cart = CartListModel.fromJson(response.responseData).cartList ?? [];
       for(CartItemModel cart in _cart){
         _totalPrice += int .parse(cart.qty ?? '');
       }
       _errorMessage = null;
       isSuccess = true;
     }
     else {
       _errorMessage = response.errorMessage ?? '';
       isSuccess = false;
     }
   }

    _inProgress =  false;
    update();
    return isSuccess;
  }

  /*
  double get totalPrice{
    double _totalPrice = 0;
    for(CartItemModel cartItem in _cart){
      // Convert qty and price to double safely
     double quantity = double.tryParse(cartItem.qty ?? '0') ?? 0;
     double price = double.tryParse(cartItem.product?.price ?? '0') ?? 0;
     _totalPrice = quantity*price;
    }
    return _totalPrice;

  }
  //Delete Cart List
void _deleteCartItem(int cartId){
    _cart.removeWhere((c) => c.id == cartId); // cartItem if matches the cartId then remove the cart
}

void changeProductQuantity(int cartId, int quantity){
    _cart.firstWhere((c) => c.id == cartId).qty == quantity; //if the item has found then item qty is updated to the new quantity// firstwhere - return the first item
    update(); // the state has changed
}
*/

  Future<bool> deleteCartList(int cartId) async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final String ? token = await AuthController.accessToken;

    if(token != null) {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .getRequest(
          url: Urls.deleteCartList(cartId),
          token: token
      );
      if (response.isSuccess && response.responseData['msg'] == 'success') {
        //_deleteCartItem(cartId);
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = response.errorMessage ?? '';
        isSuccess = false;
      }
    }

    _inProgress = false;
    update();

    return isSuccess;




  }



}