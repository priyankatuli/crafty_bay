import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/bottom_nav_bar_controller.dart';


class CategoryListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (value,_){
          backToHome();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Categories'),
            leading: IconButton(
                onPressed: (){
                    Get.find<BottomNavBarController>().backToHome();
            }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,)
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async{
              Get.find<CategoryListController>().getCategoryList();
            },
            child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
                if(categoryListController.inProgress){
                   return CenteredProgressIndicator();
                }else if(categoryListController.errorMessage!=null){
                    return Center(
                      child: Text(categoryListController.errorMessage ?? ''),
                    );
                }else if(categoryListController.categoryList.isEmpty){
                  return Center(
                    child: Text('Category is empty'),
                  );
                }
                return GridView.builder(
                    itemCount: categoryListController.categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.75
                    ),
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        categoryModel: categoryListController.categoryList[index]
                      );
                    }
                );
              }
            ),
          ),
          ),
      );
  }
  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
  }

}