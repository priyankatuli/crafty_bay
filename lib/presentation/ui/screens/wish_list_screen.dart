import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WishListScreenState();
  }
}

class _WishListScreenState extends State<WishListScreen>{
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
     onPopInvokedWithResult: (value,_){
        backToHome();
     },
      child: Scaffold(
        appBar: AppBar(
          title: Text('WishList'),
          leading: IconButton(
              onPressed: (){
                Get.find<BottomNavBarController>().backToHome();
              },
              icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: GridView.builder(
              itemCount: 20,
              itemBuilder: (context,index){
              // return ProductCard(
                //product: ProductListByCategoryController.productList[index],
               //);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8
              )
          ),
        ),
      ),
    );
  }

  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
  }

}

