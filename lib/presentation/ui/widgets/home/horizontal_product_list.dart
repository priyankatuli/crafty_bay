import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductList extends StatelessWidget {
  HorizontalProductList({
    super.key,
    required this.productList
  });

 final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(
            product: productList[index]
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8,),
        itemCount: productList.length
    );
  }
}