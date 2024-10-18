import 'dart:async';
import 'package:ecommerce_project/presentation/state_holders/otp_verification_controller.dart';
import 'package:ecommerce_project/presentation/state_holders/read_profile_controller.dart';
import 'package:ecommerce_project/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_project/presentation/ui/utils/app_colors.dart';
import 'package:ecommerce_project/presentation/ui/utils/snack_message.dart';
import 'package:ecommerce_project/presentation/ui/widgets/centered_progress_indicator.dart';
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
  final OtpVerificationController _otpVerificationController = Get.find<OtpVerificationController>();
  final ReadProfileController _readProfileController = Get.find<ReadProfileController>();

  Timer ? _timer;
  int _seconds = 120;

  void initState() {
    super.initState();
    _startTimer();

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
                    if (value
                        ?.trim()
                        .isEmpty ?? true) {
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
                            print('OTP is invalid');
                          }
                        }, child: Text('Next',)),
                      );
                    }
                ),
                const SizedBox(height: 24,),
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
                              text: '${_seconds}s',
                              style: TextStyle(
                                  color: AppColors.themeColor
                              )
                          )
                        ]
                    )
                ),
                const SizedBox(height: 12,),
                //Resend Code
                TextButton(onPressed: () {


                }, child: Text('Resend Code', style: TextStyle(
                  //color: AppColors.themeColor
                ),))
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

    void _startTimer() {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer) {
        if (mounted) {
          setState(() {
            if (_seconds > 0) {
              _seconds--;
            }
            else {
              Timer.cancel();
            }
          });
        }
      });
    }

    void dispose() {
      _otpTEController.dispose();
      _timer?.cancel();
      super.dispose();
    }

  }
