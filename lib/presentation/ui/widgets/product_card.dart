import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductDetailsScreen(productId: product.id!)
        );
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
          width: 160,
          child: Column(
              children: [
                Container(
                  width: 160,
                  height: 100,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: AppColors.themeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(product.image ?? ''),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title ?? '',maxLines: 1, style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text('\$${product.price}',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.themeColor
                              ),),
                            ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.star,color: Colors.amber,),
                              Text('${product.star}',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54
                              ),),
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            color: AppColors.themeColor,
                            child: Padding(padding: EdgeInsets.all(4),
                              child: Icon(Icons.favorite_outline_outlined,size: 16,color: Colors.white,),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}