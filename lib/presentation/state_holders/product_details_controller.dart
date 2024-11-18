import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/product_details_wrapper_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProductDetailsModel? _productModel;
  ProductDetailsModel? get productModel =>_productModel;


  Future<bool> getNewProductList(int productId) async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls. productDetailsById(productId));
    if(response.isSuccess){
      _productModel = ProductDetailsWrapperModel.fromJson(response.responseData).productDetails!.first;
      isSuccess = true;
      _errorMessage = null;

    }else{
      _errorMessage =  response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;

  }

}

