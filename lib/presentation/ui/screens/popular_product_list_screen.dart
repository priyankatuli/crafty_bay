import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/empty_list_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PopularProductListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)
        ),
        title: Text('Popular', style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 20),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: GetBuilder<PopularProductListController>(
            builder: (popularProductListController) {
              if(popularProductListController.inProgress){
                return CenteredProgressIndicator();
              }
              if(popularProductListController.errorMessage != null){
                return Center(
                  child: Text(popularProductListController.errorMessage!),
                );
              }
              if(popularProductListController.productList.isEmpty){
                return Center(
                    child: EmptyListWidget()
                );
              }
              return GridView.builder(
                  itemCount: popularProductListController.productList.length,
                  itemBuilder: (context, index) {
                    if (index >= popularProductListController.productList.length) {
                      return SizedBox.shrink();
                    }
                    return ProductCard(
                        product: popularProductListController.productList[index]
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.59,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 6.5
                  )
              );
            }
        ),
      ),
    );
  }
}