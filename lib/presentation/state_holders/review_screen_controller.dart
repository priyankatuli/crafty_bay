import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review_screen_data.dart';
import 'package:crafty_bay/data/models/review_screen_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewScreenController extends GetxController{

    bool _inProgress = false;
    bool get inProgress => _inProgress;

    String ? _errorMessage = '';
    String ? get errorMessage => _errorMessage;

    List<ReviewScreenData>? _reviewScreenDataList;
    List<ReviewScreenData> ? get reviewScreenDataList => _reviewScreenDataList;


    Future<bool> getListReview(String productId) async{
      
      bool isSuccess = false;
      _inProgress = true;
      update();
      
      final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.reviewList(productId));

      if(response.isSuccess && response.responseData['msg'] == 'success'){
        _reviewScreenDataList = ReviewScreenModel.fromJson(response.responseData).data ?? [];
        print("Review data: $_reviewScreenDataList");
        isSuccess = true;
        _errorMessage = null;
      }else{
        _errorMessage = response.errorMessage;
      }
      _inProgress = false;
      update();
      return isSuccess;
      
      
      
    }


}