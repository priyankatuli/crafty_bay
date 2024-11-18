import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/complete_user_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/new_product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/widgets.dart';
import 'popular_product_list_screen.dart';
import 'special_product_list_screen.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}
class _HomeScreenState extends State<HomeScreen> {


  Future<void> _onRefresh()async{
    await Get.find<CategoryListController>().getCategoryList();
    await Get.find<PopularProductListController>().getPopularProductList();
    await Get.find<NewProductListController>().getNewProductList();
    await Get.find<SpecialProductListController>().getSpecialProductList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16,),
                //for search bar
                SearchTextField(textEditingController: TextEditingController()),
                const SizedBox(height: 16,),
                HomeBannerSlider(),
                const SizedBox(height: 16,),
                _buildCategoriesSection(),
                const SizedBox(height: 8,),
                _buildPopularProductSection(),
                const SizedBox(height: 16,),
                _buildNewProductSection(),
                const SizedBox(height: 16,),
                _buildSpecialProductSection(),
                const SizedBox(height: 16,)
              ],
            ),
          )
              ),
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: SvgPicture.asset(
            AssetsPath.appLogoNav,
            height: 30,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        actions: [
          AppBarIconButton(
            onTap: () {
                Get.to(() => CompleteUserProfileScreen());
            },
            iconData: Icons.person,
          ),
          const SizedBox(width: 8,),
          AppBarIconButton(
            onTap: () {},
            iconData: Icons.call,
          ),
          const SizedBox(width: 8,),
          Padding(
            padding: EdgeInsets.only(right: 6),
            child: AppBarIconButton(
              onTap: () {},
              iconData: Icons.notifications_active_outlined,
            ),
          ),
        ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
            title: 'Categories',
            onTap: () {
             // Get.to(() => CategoryListScreen());
              Get.find<BottomNavBarController>().selectCategory();
            }
        ),
        SizedBox(
            height: 120,
            child:  GetBuilder<CategoryListController>(
              builder: (categoryListController){
                return Visibility(
                    visible: categoryListController.inProgress == false,
                replacement: CenteredProgressIndicator(),
                child: HorizontalCategoryListView(
                  categoryList: categoryListController.categoryList,
                )
                );
              }
            )
            ),
      ],
    );
  }

  Widget _buildPopularProductSection(){
    return Column(
      children: [
        SectionHeader(
            title: 'Popular',
            onTap: () {
                 Get.to(() => PopularProductListScreen());
            }
        ),
        SizedBox(
            height: 190,
            child: GetBuilder<PopularProductListController>(
              builder: (popularProductListController){
              return Visibility(
                  visible: popularProductListController.inProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: HorizontalProductList(productList: popularProductListController.productList)
              );
              }
            )
        ),
      ],
    );
  }

  Widget _buildNewProductSection(){
    return Column(
      children: [
        SectionHeader(
            title: 'New',
            onTap: () {
              Get.to(() => NewProductListScreen()); // same process that's why use
            }
        ),
        SizedBox(
            height: 190,
            child: GetBuilder<NewProductListController>(
              builder: (newProductListController){
              return Visibility(
                  visible: newProductListController.inProgress == false,
                  replacement : CenteredProgressIndicator(),
                  child: HorizontalProductList(productList: newProductListController.productList),
              );
              }
            )
        ),
      ],
    );
  }

  Widget _buildSpecialProductSection(){
    return Column(
      children: [
        SectionHeader(
            title: 'Special',
            onTap: () {
              Get.to(() => SpecialProductListScreen());
            }
        ),
        SizedBox(
            height: 190,
            child: GetBuilder<SpecialProductListController>(
              builder: (specialProductListController) {
                return Visibility(
                visible: !specialProductListController.inProgress,
                replacement: CenteredProgressIndicator(),
                child: HorizontalProductList(
                  productList: specialProductListController.productList,
                )
                );
              }
            )
        ),
      ],
    );
  }
}

