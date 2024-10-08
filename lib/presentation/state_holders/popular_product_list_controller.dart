import 'package:ecommerce_project/data/models/network_response.dart';
import 'package:ecommerce_project/data/models/product_list_model.dart';
import 'package:ecommerce_project/data/models/product_model.dart';
import 'package:ecommerce_project/data/services/network_caller.dart';
import 'package:ecommerce_project/data/utils/urls.dart';
import 'package:get/get.dart';

class PopularProductListController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];
  List<ProductModel> get productList{
    return _productList;
  }

  Future<bool> getPopularProductList ()async{
    bool isSuccess = false;
    _inProgress = false;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productListByRemarksUrl('popular'));
    if(response.isSuccess){
        isSuccess = true;
        _errorMessage = null;
        _productList = ProductListModel.fromJson(response.responseData).productModel ?? [];
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }



}