import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/empty_list_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewProductListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)
        ),
        title: Text('New', style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 20),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: GetBuilder<NewProductListController>(
            builder: (newProductListController) {
              if(newProductListController.inProgress){
                return CenteredProgressIndicator();
              }
              if(newProductListController.errorMessage != null){
                return Center(
                  child: Text(newProductListController.errorMessage!),
                );
              }
              if(newProductListController.productList.isEmpty){
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
                  itemCount: newProductListController.productList.length,
                  itemBuilder: (context, index) {
                    if (index >= newProductListController.productList.length) {
                      return SizedBox.shrink();
                    }
                    return ProductCard(
                        product: newProductListController.productList[index]
                    );
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