
import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/cart_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/category_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/wish_list_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../state_holders/special_product_list_controller.dart';
import 'home_screen.dart';

class MainBottomNavigationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _MainBottomNavigationScreenState();
  }

}

class _MainBottomNavigationScreenState extends State<MainBottomNavigationScreen>{

  final BottomNavBarController _navBarController = Get.find<BottomNavBarController>();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishListScreen(),
  ];

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<SliderListController>().getSliderList();
      Get.find<CategoryListController>().getCategoryList();
      Get.find<NewProductListController>().getNewProductList();
      Get.find<PopularProductListController>().getPopularProductList();
      Get.find<SpecialProductListController>().getSpecialProductList();
    });

  }

  @override
  Widget build(BuildContext context) {
      return GetBuilder<BottomNavBarController>(
        builder: (_) {
          return Scaffold(
            body: _screens[_navBarController.selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _navBarController.selectedIndex,
                onDestinationSelected: _navBarController.changedIndex,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home), label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.category_outlined),
                    label: 'Category',
                  ),
                  NavigationDestination(
                      icon: Icon(Icons.shopping_cart), label: 'Cart',
                  ),
                  NavigationDestination(
                      icon: Icon(Icons.card_giftcard_outlined),
                      label: 'Wishlist',
                  ),
                ]
            ),
          );
        }
      );
  }

}