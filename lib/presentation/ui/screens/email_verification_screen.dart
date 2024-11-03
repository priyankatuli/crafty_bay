import 'package:crafty_bay/presentation/state_holders/email_verification_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/app_constants.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget{
  const EmailVerificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
     return _EmailVerificationScreenState();
  }

}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>{

  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EmailVerificationController _emailVerificationController = Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                   children: [
                    const  SizedBox(height: 82,),
                     const AppLogoWidget(),
                     Text('Welcome Back',style: Theme.of(context).textTheme.headlineLarge,),
                     const SizedBox(height: 8,),
                     Text('Please enter your email address',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                       color: Colors.grey
                     ),),
                     const SizedBox(height: 16,),
                     TextFormField(
                       controller: _emailTEController,
                       keyboardType: TextInputType.emailAddress,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       decoration: const InputDecoration(
                         hintText: 'Email',
                       ),
                       validator: (String ? value){
                         if(value?.trim().isEmpty ?? true){
                              return 'Enter your email address';
                         }
                         if(AppConstants.emailRegExp.hasMatch(value!) == false){
                           return 'Enter your valid email address';
                         }
                         return null;
                       },
                     ),
                     const SizedBox(height: 16,),
                     GetBuilder<EmailVerificationController>(
                       builder: (emailVerificationController) {
                         return Visibility(
                           visible: emailVerificationController.inProgress == false,
                           replacement: CenteredProgressIndicator(),
                           child: ElevatedButton(onPressed: () {
                             if (_formKey.currentState!.validate()) {
                               _moveToNextScreen();
                             }
                           }, child: const Text('Next')),
                         );
                       }
                     ),
                   ],
              ),
            ),
          ),
    )
      );
  }

Future<void> _moveToNextScreen()async{

    bool result = await _emailVerificationController.getEmailVerification(_emailTEController.text.trim());
    if(result) {
      Get.to(() => OtpVerificationScreen(email: _emailTEController.text.trim(),));
    }else{
      if(mounted) {
        showSnackBarMessage(
            context, _emailVerificationController.errorMessage!, true);
      }
    }
}
  @override
  void dispose(){
    _emailTEController.dispose();
    super.dispose();


  }

}