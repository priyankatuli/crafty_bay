
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;

  bool _isProfileCompleted = false;

  bool get isProfileCompleted => _isProfileCompleted;


  Future<bool> getReadProfile(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.readProfile,
        token: token
    );
    if (response.isSuccess){
      if (response.responseData['data'] != null) {
        _isProfileCompleted = true;
        await Get.find<AuthController>().saveAccessToken(token);
      }else{
        _isProfileCompleted = false;
      }
    _errorMessage = null;
      isSuccess = true;
  }
    else{
    _errorMessage = response.errorMessage ?? 'Failed to read profile';
  }
    _inProgress = false;
    update();
    return isSuccess;


  }






}