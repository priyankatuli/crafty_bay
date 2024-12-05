import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wishlist_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/show_snack_bar_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/empty_wish_list.dart';
import 'package:crafty_bay/presentation/ui/widgets/wish_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WishListScreenState();
  }
}

class _WishListScreenState extends State<WishListScreen>{

  Future<void> _initializer() async{
    bool result = await Get.find<WishlistController>().getWishlist();
    if(result == false){
      ShowSnackBarMessage(context, 'Please login!!');
      Get.to(() => EmailVerificationScreen());
    }
  }

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _initializer();
    });

  }

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
                //Get.find<BottomNavBarController>().backToHome();
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            await Get.find<WishlistController>().getWishlist();
          },
          child: GetBuilder<WishlistController>(
            builder: (wishListController) {
              if(wishListController.inProgress){
                return CenteredProgressIndicator();
              }
              else if(wishListController.errorMessage != null){
                return Center(
                  child: Text(wishListController.errorMessage ?? 'An error occurred'),
                );
              }
              else if(wishListController.wishList!.isEmpty){
                return Center(
                    child: EmptyWishList()
                );
              }
                return GridView.builder(
                    itemCount: wishListController.wishList?.length,
                    itemBuilder: (context, index) {
                      return WishProductCard(
                        wishData: wishListController.wishList![index]
                          //price: wishListController.wishList?[index].product?.price ?? 'No product price found',
                          //image: wishListController.wishList?[index].product?.image ?? '',
                          //title: wishListController.wishList?[index].product?.title ?? 'No product title found',
                          //star: wishListController.wishList![index].product?.star ?? 0 ,
                          //productId: wishListController.wishList?[index].productId ?? 0
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 4
                    )
              );
            }
          ),
        ),
        ),
    );
  }

  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
  }

}

