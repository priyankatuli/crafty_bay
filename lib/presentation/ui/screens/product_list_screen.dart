import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/empty_list_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductListScreen extends StatefulWidget{

  ProductListScreen({super.key,required this.category});

  ///final String categoryName;
  final CategoryModel category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  void initState(){
    super.initState();
    Get.find<ProductListByCategoryController>().getListProductByCategory(widget.category.id!);

  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
           title: Text(widget.category.categoryName ?? ''),
         ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: GetBuilder<ProductListByCategoryController>(
            builder: (productListByCategoryController) {
              if(productListByCategoryController.inProgress){
                return CenteredProgressIndicator();
              }
              if(productListByCategoryController.errorMessage != null){
                  return Center(
                    child: Text(productListByCategoryController.errorMessage!),
                  );
              }
              if(productListByCategoryController.productList.isEmpty){
                return Center(
                  child: EmptyListWidget()
                  /*Text('Empty product list!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                  )
                  ),
                   */
                );
              }
              return GridView.builder(
                  itemCount: productListByCategoryController.productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productListByCategoryController.productList[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8
                  )
              );
            }
          ),
        ),
      );
  }
}