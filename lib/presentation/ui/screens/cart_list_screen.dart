import 'package:ecommerce_project/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:ecommerce_project/presentation/ui/screens/review_screen.dart';
import 'package:ecommerce_project/presentation/ui/widgets/cart_item_screen.dart';
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

  @override
  Widget build(BuildContext context) {
     return PopScope(
       canPop: false,
       onPopInvoked: (value) {
         backToHome();
       },
       child: Scaffold(
         backgroundColor: Colors.grey.shade100,
         appBar: AppBar(
           title: Text('Cart'),
           leading: IconButton(
               onPressed: (){
                 backToHome();
               },
               icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,)
           ),
         ),
             body:
               Column(
                 children: [
                   Expanded(
                       child: ListView.builder(
                         itemCount: 6,
                           itemBuilder: (context,index){
                             return const CartItemScreen();
                           }
                       ),
                   ),
                   _buildPriceAndAddToCartSection(),
                 ],
               ),
             ),
     );
  }

  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
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
              Text('Price'),
              Text('\$1000',
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
                  Get.to(() => ReviewScreen());
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
}


