import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wishlist.dart';
import 'package:crafty_bay/presentation/state_holders/delete_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/payment_method_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review_screen_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'presentation/state_holders/add_to_cart_controller.dart';
import 'presentation/state_holders/auth_controller.dart';
import 'presentation/state_holders/bottom_nav_bar_controller.dart';
import 'presentation/state_holders/cart_list_controller.dart';
import 'presentation/state_holders/category_list_controller.dart';
import 'presentation/state_holders/countdown_timer_controller.dart';
import 'presentation/state_holders/email_verification_controller.dart';
import 'presentation/state_holders/new_product_list_controller.dart';
import 'presentation/state_holders/otp_verification_controller.dart';
import 'presentation/state_holders/popular_product_list_controller.dart';
import 'presentation/state_holders/product_details_controller.dart';
import 'presentation/state_holders/product_list_by_category_controller.dart';
import 'presentation/state_holders/read_profile_controller.dart';
import 'presentation/state_holders/slider_list_controller.dart';
import 'presentation/state_holders/special_product_list_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController(),fenix: true);
    Get.put(SliderListController());
    Get.put(AuthController());
    Get.lazyPut(() => NetworkCaller(
        logger: Get.find<Logger>(),
        authController: Get.find<AuthController>(),
    ), fenix: true);
    Get.lazyPut(() => Logger(),fenix: true);
    Get.lazyPut(() => CategoryListController(),fenix: true);
    Get.lazyPut(() => NewProductListController(),fenix: true);
    Get.lazyPut(() => PopularProductListController(),fenix: true);
    Get.lazyPut(() => SpecialProductListController(),fenix: true);
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(EmailVerificationController());
    Get.put(AddToCartController());
    Get.lazyPut(() => CartListController(),fenix: true);
    Get.lazyPut(() => WishlistController(),fenix: true);
    Get.lazyPut(() => AddToWishList(),fenix: true);
    Get.lazyPut(() => DeleteWishListController(),fenix: true);
    Get.lazyPut(() => OtpVerificationController(),fenix: true);
    Get.lazyPut(() => ReadProfileController(),fenix: true);
    Get.lazyPut(() => CountdownTimerController(),fenix: true);
    Get.lazyPut(() => PaymentMethodListController(),fenix: true);
    Get.lazyPut(() => ReviewScreenController(),fenix: true);
  }
}