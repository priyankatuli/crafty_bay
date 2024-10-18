
import 'package:ecommerce_project/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_project/presentation/state_holders/product_details_controller.dart';
import 'package:ecommerce_project/presentation/state_holders/product_details_model.dart';
import 'package:ecommerce_project/presentation/ui/screens/email_verification_screen.dart';
import 'package:ecommerce_project/presentation/ui/utils/app_colors.dart';
import 'package:ecommerce_project/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:ecommerce_project/presentation/ui/widgets/product_image_slider.dart';
import 'package:ecommerce_project/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _ProductDetailsScreen();
  }

  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});
}

class _ProductDetailsScreen extends State<ProductDetailsScreen>{

  void initState(){
    super.initState();
    Get.find<ProductDetailsController>().getNewProductList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
            if(productDetailsController.inProgress){
              return CenteredProgressIndicator();
            }
            if(productDetailsController.errorMessage != null){
              return Center(
                child: Text(productDetailsController.errorMessage!),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: _buildProductDetails(productDetailsController.productModel!),
                ),
                _buildPriceAndAddToCartSection(productDetailsController.productModel!)
              ],
            );
          }
        ),
      );
  }

  Widget _buildProductDetails(ProductDetailsModel product) {
    return SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(
                      sliderUrls: [
                        product.img1!,
                        product.img2!,
                        product.img3!,
                        product.img4!,
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNameSection(product),
                              _buildNameAndQuantitySection(product),
                            ],
                          ),
                          _buildRatingAndReviewSection(product),
                          const SizedBox(height: 8,),
                         /* ColorPicker(colors: [
                           Colors.black26,
                           Colors. purple.shade200,
                           Colors.brown,
                           Colors.green.shade200,
                           Colors.grey.shade200
                          ],
                            onColorSelected: (colors){
                            },),
                          */
                          SizePicker(
                              sizes: product.color!.split(','),
                              onSizedSelected: (String selectedSize){}
                          ),

                          const SizedBox(height: 8,),
                          SizePicker(
                              sizes: product.size!.split(','),
                              onSizedSelected: (String selectedSize){}
                          ),
                          const SizedBox(height: 16,),

                          _buildDescriptionSection(product),
                        ],
                      ),
                    )
                  ],
                ),
              );
  }

  Widget _buildNameSection(ProductDetailsModel productDetails) {
    return Expanded(
                                child: Text(productDetails.product?.title ?? '',
                                  style: Theme.of(context).textTheme.titleMedium,
                                )
                            );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description',style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: 8,),
                            Text(productDetails.des ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54
                              ), ),
                          ],
                        );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
                              children:[
                                Card(
                                  color: AppColors.themeColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Container(
                                    child: IconButton(onPressed: (){

                                    }, icon: Icon(Icons.remove,color: Colors.white54,)
                                      ),
                                    padding: EdgeInsets.all(0.0),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Text('1', style: Theme.of(context).textTheme.titleMedium
                                 ),
                                const SizedBox(width: 5,),
                                Card(
                                  color: AppColors.themeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    child: Icon(Icons.add,color: Colors.white54,size: 20,),
                                    padding: EdgeInsets.all(2),
                                  ),
                                ),
                              ],);
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.star,color: Colors.amber,),
                                Text('${productDetails.product?.star ?? ''}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54
                                    )
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: (){

                              }, child: Text('Reviews',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.themeColor),
                            ),),
                            Card(
                              color: AppColors.themeColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.favorite_outline_outlined,color: Colors.white54,size: 16,),
                              ),
                            ),
                          ],
                        );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
    return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price'),
                      Text('\$${productDetails.product?.price ?? ''}',
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
                                  _onTapAddToCart();
                              },
                              child: Text('Add to Cart',
                              style: TextStyle(
                                //color: AppColors.themeColor,
                                fontSize: 17
                              ),),
                          ),
                        ),
                ],
              ),
            );
  }

  Future<void> _onTapAddToCart() async{

    bool isLoggedInUser = await Get.find<AuthController>().isLoggedInUser();
    if(isLoggedInUser){

    }else{
      Get.to(() => EmailVerificationScreen());
    }


  }

}