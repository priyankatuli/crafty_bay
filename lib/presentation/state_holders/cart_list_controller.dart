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



  double get totalPrice {
    return _cart.fold(0, (sum, item) {
      double qty = double.tryParse(item.qty ?? '0') ?? 0;
      double price = double.tryParse(item.product?.price ?? '0') ?? 0;
      return sum + (qty * price);
    });
  }


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
       _errorMessage = null;
       update();
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