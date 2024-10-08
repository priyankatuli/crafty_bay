import 'package:ecommerce_project/data/models/network_response.dart';
import 'package:ecommerce_project/data/models/slider_list_model.dart';
import 'package:ecommerce_project/data/models/slider_model.dart';
import 'package:ecommerce_project/data/services/network_caller.dart';
import 'package:ecommerce_project/data/utils/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController{

  bool _inProgress = false;
  bool get inProgress{
    return _inProgress;
  }

  String ? _errorMessage;
  String ? get errorMessage => _errorMessage;

  List<SliderModel> _sliderList = [];
  List<SliderModel> get sliderList => _sliderList;

  Future<bool> getSliderList() async{

    bool isSuccess = false;
    _inProgress =  true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.sliderListUrl);
    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
      _sliderList = SliderListModel.fromJson(response.responseData).sliderList ?? [];
    }else{
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess ;
  }

}