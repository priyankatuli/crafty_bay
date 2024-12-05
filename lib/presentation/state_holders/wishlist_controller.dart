import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_list_item.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController{

  String ? _errorMessage = '';
  String ? get errorMessage => _errorMessage;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  List<WishListItem> ? _wishList = [];
  List<WishListItem> ? get wishList => _wishList;

  List<int> _wishListProductId = [];

  Future<bool> getWishlist() async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final String ? token = await AuthController.accessToken;

    if(token != null) {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .getRequest(url: Urls.getWishList, token: token
      );
      if(response.isSuccess && response.responseData['msg'] == 'success'){
        _wishList = WishlistModel.fromJson(response.responseData).data ?? [];
        _errorMessage = null;
        isSuccess = true;
      }else{
        _errorMessage = response.errorMessage;
      }
    }

    _inProgress = false;
    update();

    return isSuccess;


  }




}