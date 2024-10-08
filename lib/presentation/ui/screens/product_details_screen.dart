
import 'package:ecommerce_project/presentation/ui/utils/app_colors.dart';
import 'package:ecommerce_project/presentation/ui/widgets/color_picker.dart';
import 'package:ecommerce_project/presentation/ui/widgets/product_image_slider.dart';
import 'package:ecommerce_project/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _ProductDetailsScreen();
  }

}

class _ProductDetailsScreen extends State<ProductDetailsScreen>{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: Column(
            children: [
              Expanded(
                child: _buildProductDetails(),
              ),
              _buildPriceAndAddToCartSection()
            ],
          ),
      );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageSlider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text('Nike shoe 2024 latest model - New year special deal save 30%',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                              ),
                              _buildNameAndQuantitySection(),
                            ],
                          ),
                          _buildRatingAndReviewSection(),
                          const SizedBox(height: 8,),
                          ColorPicker(colors: [
                            Colors.black,
                            Colors.purple.shade200,
                            Colors.brown.shade300,
                            Colors.green.shade200,
                            Colors.grey
                          ],
                            onColorSelected: (colors){

                            },),
                          const SizedBox(height: 8,),
                          SizePicker(
                              sizes: [
                                'S',
                                'M',
                                'L',
                                'XL',
                                'XXL'
                              ],
                              onSizedSelected: (String selectedSize){}
                          ),
                          const SizedBox(height: 16,),

                          _buildDescriptionSection(),
                        ],
                      ),
                    )
                  ],
                ),
              );
  }

  Widget _buildDescriptionSection() {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description',style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: 8,),
                            Text('''For an e-commerce project focused on shoes, it's essential to create an engaging and comprehensive platform that appeals to a wide range of customers while offering a smooth and intuitive shopping experience.''',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54
                              ), ),
                          ],
                        );
  }

  Widget _buildNameAndQuantitySection() {
    return Row(
                              children:[
                                Card(
                                  color: AppColors.themeColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Container(
                                    child: Icon(Icons.remove,color: Colors.white54,size: 20,),
                                    padding: EdgeInsets.all(2),
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

  Widget _buildRatingAndReviewSection() {
    return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.star,color: Colors.amber,),
                                Text('3',
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

  Widget _buildPriceAndAddToCartSection() {
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
                              onPressed: (){},
                              child: Text('Add to Cart',
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