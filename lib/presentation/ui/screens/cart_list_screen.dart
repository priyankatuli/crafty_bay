
import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/home_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/cart_item_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class CartListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _CartListScreenState();
  }

}

class _CartListScreenState extends State<CartListScreen>{

  final cartController = Get.find<CartListController>();

  Future<void> _initializer()async{
    bool result = await Get.find<CartListController>().getCartList();
    if(result == false){
      showSnackBarMessage(context, 'Please login!');
      Get.to(() => const EmailVerificationScreen());
    }
  }

  void initState(){
    super.initState();
    _initializer();
  }

  @override
  Widget build(BuildContext context) {
     return PopScope(
       canPop: false,
       onPopInvokedWithResult: (value,_){
            Get.find<BottomNavBarController>().backToHome();
       },
       child: Scaffold(
               backgroundColor: Colors.grey.shade100,
               appBar: AppBar(
                 title: Text('Cart'),
                 leading: IconButton(
                     onPressed: (){
                       print('Back button pressed');
                       Get.find<BottomNavBarController>().backToHome();
                     },
                     icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,)
                 ),
               ),
                   body: RefreshIndicator(
                     onRefresh: () async{
                       Get.find<CartListController>().getCartList();
                     },
                     child: GetBuilder<CartListController>(
                         builder: (cartListController) {
                           if(cartListController.inProgress){
                             return CenteredProgressIndicator();
                           }
                           else if(cartListController.errorMessage != null){
                             return Center(
                               child: Text(cartListController.errorMessage ?? ''),
                             );
                           } else if(cartListController.cart.isEmpty){
                             return Center(
                               child: Text('Cart list empty', style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20
                               ),),
                             );
                           } else {
                             return Column(
                               children: [
                                 Expanded(
                                   child: ListView.builder(
                                       itemCount: cartListController.cart.length,
                                       itemBuilder: (context, index) {
                                         return CartItemScreen(
                                           cartItem: cartListController.cart[index],
                                           index : index
                                         );
                                       }
                                   ),
                                 ),
                                 _buildPriceAndAddToCartSection(),
                               ],
                             );
                           }
                         }
                       ),

                   ),
         ),
     );
  }

  Widget _buildPriceAndAddToCartSection() {

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price'),
              Text(cartController.totalPrice.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.themeColor
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
                onPressed: (){
                    // Get.to(() => const CheckoutScreen());
                  //navigate to payment screen
                },
                child: Text('Checkout',
                  style: TextStyle(
                    //color: AppColors.themeColor,
                      fontSize: 17
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  void dispose(){

    super.dispose();

  }


}


