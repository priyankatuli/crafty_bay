import 'package:crafty_bay/data/models/wish_list_item.dart';
import 'package:crafty_bay/presentation/state_holders/delete_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wishlist_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/show_snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishProductCard extends StatelessWidget{

  WishProductCard({
    super.key,
    //required this.price,
    //required this.image,
    //required this.title,
    //required this.star,
    //required this.productId,
    required this.wishData
});

 // final String title;
  //final String price;
  //final int star;
  //final String image;
  //final int productId;
  final WishListItem wishData;


  @override
  Widget build(BuildContext context) {
     return InkWell(
       onTap: (){
         Get.to(() => ProductDetailsScreen(productId: wishData.productId!));
       },
       child: Card(
         elevation: 3,
         color: Colors.white,
         child: SizedBox(
           width: 160,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 height: 100,
                 width: 160,
                 decoration: BoxDecoration(
                     color: AppColors.themeColor.withOpacity(0.2),
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(8),
                     topRight: Radius.circular(8)
                   ),
                   image: DecorationImage(image: NetworkImage(wishData.product?.image ?? ''),fit: BoxFit.cover)
                 ),
               ),
               Padding(
                   padding: EdgeInsets.all(8),
                 child: Text(wishData.product?.title ?? 'No title found',maxLines: 1,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                       color: Colors.black54,
                       fontWeight: FontWeight.w500
                     ),),
               ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text('\$${wishData.product?.price ?? 'No product price found'}',style: TextStyle(fontWeight: FontWeight.w500,
                         color: AppColors.themeColor
                         ),),
                       Row(
                         mainAxisSize: MainAxisSize.min, //prevent this row from expanding unnecessary spaces
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Icon(Icons.star,color: Colors.amber,),
                           Text(wishData.product?.star.toString() ?? '',style: TextStyle(
                             color: Colors.black54
                           ),)
                         ],
                       ),
                         Flexible(  // flexible way te child property ke handle kore
                           child: InkWell(
                             onTap: ()async {
                               bool result = await Get.find<DeleteWishListController>().deleteWishList(wishData.productId.toString());
                               if(result){
                                  Get.find<WishlistController>().getWishlist();
                                  ShowSnackBarMessage(context, "Deleted Wishlist");
                               }else{
                                 ShowSnackBarMessage(context, 'Failed to delete wishlist! Please login');
                                 Get.to(() => EmailVerificationScreen());
                               }
                             },
                             child: GetBuilder<DeleteWishListController>(
                               builder: (deleteWishListController) {
                                 return Visibility(
                                     visible: deleteWishListController.inProgress == false,
                                 replacement: Container(
                                 width: 17,
                                 height: 17,
                                 decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(4)),
                               ),
                                   child: Icon(Icons.delete_outline_outlined,color: Colors.grey,
                                 ));
                               }
                             ),
                           ),
                         ),
                         ],
                       )
                       ],
                     )
                 ),
               )
     );
  }

}