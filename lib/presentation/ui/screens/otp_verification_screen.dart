import 'dart:async';
import 'package:crafty_bay/presentation/state_holders/countdown_timer_controller.dart';
import 'package:crafty_bay/presentation/state_holders/email_verification_controller.dart';
import 'package:crafty_bay/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/app_logo_widget.dart';
import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget{
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<StatefulWidget> createState() {
      return _OtpVerificationScreenState();
  }

}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController = Get.find<EmailVerificationController>();
  final OtpVerificationController _otpVerificationController = Get.find<OtpVerificationController>();
  final ReadProfileController _readProfileController = Get.find<ReadProfileController>();

  Timer ? _timer;
  //int _seconds = 120;

  void initState() {
    super.initState();
    _startTimer();

  }

  void _startTimer() {
    //to cancel existing timer
    //_timer?.cancel();
    //then reset it again
    Get.find<CountdownTimerController>().resetTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer) {
      if (mounted) {
        if (Get.find<CountdownTimerController>().seconds == 0) {
          Timer.cancel();
        }
        Get.find<CountdownTimerController>().decreaseTime();
      }
      //  if (_seconds > 0) {
      //  _seconds--;
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 82,),
                AppLogoWidget(),
                Text('Enter Otp Code', style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,),
                const SizedBox(height: 8,),
                Text(
                  'A 6 digit otp has been sent to email address', style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
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
                  validator: (String ? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter the OTP';
                    }
                    else if (value!.length < 6) {
                      return 'OTP must be 6 digits long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                GetBuilder<OtpVerificationController>(
                    builder: (otpVerificationController) {
                      return Visibility(
                        visible: otpVerificationController.inProgress == false,
                        replacement: CenteredProgressIndicator(),
                        child: ElevatedButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onTapNextButton();
                          } else {
                            showSnackBarMessage(context, 'Please enter a valid Otp');
                          }
                        }, child: Text('Next',)),
                      );
                    }
                ),
                const SizedBox(height: 24,),

                GetBuilder<CountdownTimerController>(
                  builder: (timer) {
                   return Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'The code will expire in ',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: Colors.grey
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${timer.seconds}s',
                                        style: TextStyle(
                                            color: AppColors.themeColor
                                        )
                                    )
                                  ]
                              )
                          ),

                const SizedBox(height: 12,),
                TextButton(
                  onPressed: timer.seconds == 0 ? () async {
                    // Call your method to resend the OTP
                   bool resendOtp = await _emailVerificationController.getEmailVerification(widget.email);
                   if(resendOtp && mounted) {
                       showSnackBarMessage(context, 'Otp has been resent successfully');
                       // Restart the timer
                       _startTimer();
                   }else{
                     showSnackBarMessage(context, _emailVerificationController.errorMessage!);
                   }
                  } : null,
                  child: Text('Resend Code', style: TextStyle(
                    color: (timer.seconds == 0) ? AppColors.themeColor : null
                ),),
                )
                    ]
                   );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    bool result = await _otpVerificationController.getVerifyLogin(
        widget.email,
        _otpTEController.text
    );
    if (result) {
      final bool readProfileResult =  await _readProfileController.getReadProfile(_otpVerificationController.accessToken);
      if(readProfileResult){
         //when you successfully navigate different screen the timer stops
        _timer?.cancel();
        if(_readProfileController.isProfileCompleted){
            Get.offAll(() => MainBottomNavigationScreen());
        }else{
          Get.to(() => CompleteProfileScreen());
        }
      }
      else{
      if(mounted){
        showSnackBarMessage(context, _readProfileController.errorMessage!);
      }
    }
  } else{
      if(mounted){
        showSnackBarMessage(context, _otpVerificationController.errorMessage!);
      }
    }
  }

    void dispose() {
      _otpTEController.dispose();
      _timer?.cancel();
      super.dispose();
    }

  }
