
import 'package:crafty_bay/data/models/category_list_model.dart';
import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController{
  
  bool _inProgress =  false;
  bool get inProgress => _inProgress;
  
  String ? _errorMessage;
  String ? get errorMessage{
    return _errorMessage;
  }

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;

  
  Future<bool> getCategoryList()async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.categoryListUrl);

    if(response.isSuccess){
      _categoryList = CategoryListModel.fromJson(response.responseData).categoryList ?? [];
    }else{
       _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}