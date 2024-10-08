
import 'package:get/get.dart';

class BottomNavBarController extends GetxController{
  int _selectedIndex = 0;

  int get selectedIndex{  //getter method to modify but can't do setup
    return _selectedIndex;
  }

  void changedIndex(int index){
    _selectedIndex = index;
    update();
  }

  void selectCategory(){
    changedIndex(1);
  }

  void backToHome(){
    changedIndex(0);
  }






}