
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class NewProductListController extends GetxController{

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];
  List<ProductModel>  get productList{
    return _productList;
  }

  Future<bool> getNewProductList() async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.productListByRemarksUrl('new'));
    if(response.isSuccess){
      _productList = ProductListModel.fromJson(response.responseData).productModel ?? [];
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