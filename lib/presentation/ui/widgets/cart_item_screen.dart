import 'package:ecommerce_project/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/assets_path.dart';

class CartItemScreen extends StatelessWidget {
  const CartItemScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title of Product',style: textTheme.bodyLarge,),
                          _buildColorAndSize(textTheme)
                        ],
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.grey,))
                  ],
                ),
                _buildPriceAndCountSection(textTheme,context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
                          spacing: 8,
                          children: [
                            Text('Color: Red',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                            Text('Size: XL',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                          ],
                        );
  }

  Widget _buildPriceAndCountSection(TextTheme textTheme,BuildContext context) {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$1000',style: textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor
                  )),
                  Row(
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
                    ],
                  ),
                ],
              );
  }

  Widget _buildProductImage() {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsPath.dummyProductImage,
            height: 80,
            width: 80,
            fit: BoxFit.scaleDown,
          ),
        );
  }
}


