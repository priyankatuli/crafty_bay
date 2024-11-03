import 'package:crafty_bay/presentation/ui/utils/app_constants.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
       return _CompleteProfileScreenState();
  }
  
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>{

  TextEditingController _firstNameTEController = TextEditingController();
  TextEditingController _secondNameTEController = TextEditingController();
  TextEditingController _mobileTEController = TextEditingController();
  TextEditingController _cityTEController = TextEditingController();
  TextEditingController _shippingAddressTEController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 32,),
                AppLogoWidget(),
                const SizedBox(height: 24,),
                Text('Complete Profile',
                  style: Theme.of(context).textTheme.headlineLarge
                ),
                const SizedBox(height: 8,),
                Text('Get Started with us your details',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey
                ),),
                const SizedBox(height: 24,),
                TextFormField(
                  controller: _firstNameTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'First Name'
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                       return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _secondNameTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: 'Second Name'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Enter your second name';
                      }
                      return null;
                    },
                ),
                const SizedBox(height: 8,),
            TextFormField(
              controller: _mobileTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Mobile'
              ),
              validator: (String ? value){
                if(value == null || value.trim().isEmpty){
                  return 'Enter your mobile number';
                }
                if(AppConstants.mobileRegExp.hasMatch(value) == false){
                  return 'Enter your valid mobile number';
                }
                return null;
              },
            ),
                const SizedBox(height: 8,),
            TextFormField(
              controller: _cityTEController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'City'
              ),
              validator: (String ? value){
                if(value == null || value.trim().isEmpty){
                  return 'Enter your city';
                }
                return null;
              },
            ),
                const SizedBox(height: 8,),
            TextFormField(
              controller: _shippingAddressTEController,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'Shipping Address'
              ),
              validator: (String ? value){
                if(value == null || value.trim().isEmpty){
                  return 'Enter your shipping address';
                }
                return null;
              },
            ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){

                  }
                }, child: Text('Complete')),
              ],
            ),
          ),
        ),
      );
  }
  void dispose(){

    _firstNameTEController.dispose();
    _secondNameTEController.dispose();
    _mobileTEController.dispose();
    _shippingAddressTEController.dispose();
    _cityTEController.dispose();
    super.dispose();

  }
  
}