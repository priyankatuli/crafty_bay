
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends  GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;


  Future<bool> getListProductByCategory(int categoryId) async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Urls.listProductByCategory(categoryId));

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
      _productList= ProductListModel.fromJson(response.responseData).productModel ?? [];

    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}