import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/empty_list_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/special_product_list_controller.dart';


class SpecialProductListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)
        ),
        title: Text('Special', style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 20),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: GetBuilder<SpecialProductListController>(
            builder: (specialProductListController) {
              if(specialProductListController.inProgress){
                return CenteredProgressIndicator();
              }
              if(specialProductListController.errorMessage != null){
                return Center(
                  child: Text(specialProductListController.errorMessage!),
                );
              }
              if(specialProductListController.productList.isEmpty){
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
                  itemCount: specialProductListController.productList.length,
                  itemBuilder: (context, index) {
                    if (index >= specialProductListController.productList.length) {
                      return SizedBox.shrink();
                    }
                    return ProductCard(
                        product: specialProductListController.productList[index]
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