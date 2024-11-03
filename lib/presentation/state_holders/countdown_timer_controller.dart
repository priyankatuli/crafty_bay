import 'package:get/get.dart';

class CountdownTimerController extends GetxController{

   int _seconds = 120;
   int get seconds => _seconds;


   void resetTime(){
     if(_seconds != 120){
       _seconds = 120;
     }
   }
   void decreaseTime(){
     if(_seconds > 0) {
       _seconds--;
     }
     update();
     print('Seconds left: $_seconds'); // Add this debug line
   }

}