import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
     return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    _moveNextToScreen();

  }
  @override
  Widget build(BuildContext context) {
      return const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Spacer(),
                AppLogoWidget(),
                Spacer(),
                 CircularProgressIndicator(),
                 SizedBox(height: 16,),
                 Text('version 1.0.0',style: TextStyle(
                   color: Colors.grey
                 ),)
               ],
            ),
          ),
        ),
      );
  }

  Future<void> _moveNextToScreen()async {
    await Future.delayed(const Duration(seconds: 2));
    //Get.off(() => const EmailVerificationScreen());
   // Get.off( () => HomeScreen());
    await Get.find<AuthController>().getAccessToken();
   Get.off( () => MainBottomNavigationScreen());
  }

}