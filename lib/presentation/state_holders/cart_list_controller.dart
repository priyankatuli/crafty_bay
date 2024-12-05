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


    //to fetch getCartList
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
       _calculateTotalPrice(); // calculate total price after fetching data
       _errorMessage = null;
       isSuccess = true;
     }
     else {
       _errorMessage = response.errorMessage ?? '';
       update();
       isSuccess = false;
     }
   }

    _inProgress =  false;
    update();
    return isSuccess;
  }

  Future<bool> deleteCartList(int cartId) async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final String ? token = await AuthController.accessToken;

    if(token != null) {
      final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
          url: Urls.deleteCartList(cartId),
          token: token
      );
      if (response.isSuccess && response.responseData['msg'] == 'success') {
        // Remove the item from the local cart list
        _cart.removeWhere((item) => item.productId == cartId);
        _calculateTotalPrice(); //after deletion recalculate total price
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

  void _calculateTotalPrice(){

    _totalPrice = 0;
    for (CartItemModel cart in _cart){
      int unitPrice = int.parse(cart.product?.price ?? '0') ;
      int quantity = int.parse(cart.qty ?? '1');
      _totalPrice += unitPrice * quantity;
    }
    update();
  }

  void updateQuantity(int productId, newQuantity){

    for(CartItemModel cartItem in _cart){
      if(cartItem.productId == productId){
        cartItem.qty = newQuantity.toString();  //update quantity
        break;
      }
    }
    _calculateTotalPrice(); //recalculate total price
    update(); //notify the UI to rebuild
  }

  }
