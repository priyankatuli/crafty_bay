import 'dart:async';

import 'package:ecommerce_project/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/app_logo_widget.dart';
import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget{
  const OtpVerificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
      return _OtpVerificationScreenState();
  }

}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>{

  final TextEditingController _otpTEController = TextEditingController();
  Timer ? _timer;
  int _seconds = 120;

  void initState(){
    super.initState();
    _startTimer();

  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 82,),
                  AppLogoWidget(),
                  Text('Enter Otp Code',style: Theme.of(context).textTheme.headlineLarge,),
                  const SizedBox(height: 8,),
                  Text('A 6 digit otp has been sent to email address',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey
                  ),),
                  const SizedBox(height: 16,),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.green,
                      inactiveFillColor: Colors.white,
                      inactiveColor: AppColors.themeColor
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _otpTEController,
                    keyboardType: TextInputType.number,
                    appContext: context,
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(onPressed: (){
                        _onTapNextButton();
                  }, child: Text('Next',)),
                  const SizedBox(height: 24,),
                  RichText(
                      text: TextSpan(
                        text: 'The code will expire in ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey
                        ),
                        children: [
                           TextSpan(
                             text: '${_seconds}s',
                             style: TextStyle(
                               color: AppColors.themeColor
                             )
                           )
                        ]
                      )
                  ),
                  const SizedBox(height: 12,),
                  TextButton(onPressed: (){

                  }, child: Text('Resend Code',style: TextStyle(
                    //color: AppColors.themeColor
                  ),))
                ],
              ),
            ),
        ),
      );
  }

  void _onTapNextButton(){
    Get.to(() => CompleteProfileScreen());
  }
  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (Timer){
      if(mounted){
        setState(() {
          if(_seconds > 0){
            _seconds--;
          }
          else{
            Timer.cancel();
          }
        });
      }
    });
  }

  void dispose(){
    _otpTEController.dispose();
    _timer?.cancel();
    super.dispose();
  }

}