import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wishlist.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wishlist_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/cart_list_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/wish_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/show_snack_bar_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'review_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId,});

  final int productId;


  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final AddToWishList _createWishListController = Get.find<AddToWishList>();

  bool isAddedWishList = false;

  String _selectedColor = '';
  String _selectedSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Get.find<ProductDetailsController>().getNewProductList(widget.productId);
      if(AuthController.accessToken != null){
        Get.find<WishlistController>().getWishlist();
        _checkProductInWishList();
      }
    });
  }

  void _checkProductInWishList(){
    _createWishListController.isAddedWishList(widget.productId);
    setState(() {
      isAddedWishList = _createWishListController.isProductAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
            if (productDetailsController.inProgress) {
              return CenteredProgressIndicator();
            }
            if (productDetailsController.errorMessage != null) {
              return Center(
                child: Text(productDetailsController.errorMessage!),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: _buildProductDetails(
                      productDetailsController.productModel!),
                ),
                _buildPriceAndAddToCartSection(
                    productDetailsController.productModel!)
              ],
            );
          }),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel product) {
    List<String> colors = product.color!.split(',');
    List<String> sizes = product.size!.split(',');
    _selectedColor = colors.first;
    _selectedSize = sizes.first;

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              product.img1 ?? '',
              product.img2 ?? '',
              product.img3 ?? '',
              product.img4 ?? '',
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(product),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(product),
                const SizedBox(height: 8),
                // ColorPicker(
                //   colors: const [
                //     Colors.red,
                //     Colors.green,
                //     Colors.yellow,
                //     Colors.black,
                //   ],
                //   onColorSelected: (color) {},
                // ),
                SizePicker(
                  sizes: colors,
                  onSizedSelected: (String selectedColor) {
                    _selectedColor = selectedColor;
                  },
                ),
                const SizedBox(height: 16),
                SizePicker(
                  sizes: sizes,
                  onSizedSelected: (String selectedSize) {
                    _selectedSize = selectedSize;
                  },
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(product)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          productDetails.product?.shortDes ?? '',
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            productDetails.product?.title ?? '',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
        ),
        ItemCount(
          initialValue: quantity,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            setState(() {
              quantity = value.toInt(); // trigger UI rebuild
            });
          },
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber),
            Text(
              '${productDetails.product?.star ?? ''}',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            Get.to(() => ReviewScreen());
          },
          child: const Text(
            'Reviews',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.themeColor),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
            onTap: () async {
              final authController = Get.find<AuthController>();
              final addToWishlistControlller = Get.find<AddToWishList>();
              if (authController.isLoggedInUser()) {
                bool result = await addToWishlistControlller.createWishList(
                    widget.productId);
                if (result) {
                  ShowSnackBarMessage(context, 'Added to wishlist');
                  Get.to(() => WishListScreen());
                } else {
                  ShowSnackBarMessage(context, 'please login');
                  Get.to(() => EmailVerificationScreen());
                }
              } else {
                ShowSnackBarMessage(context, 'Please Login');
                Get.to(() => EmailVerificationScreen());
              }
            },
            child: GetBuilder<AddToWishList>(
                builder: (addToWishListController) {
                  return Visibility(
                      visible: addToWishListController.inProgress == false,
                      replacement: SizedBox(
                        height: 20,
                        width: 20,
                        child: CenteredProgressIndicator(),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(Icons.favorite_outline_outlined,
                          color: Colors.white,
                          size: 13,),)
                  );
                }
            )
        )
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
    double basePrice = double.tryParse(productDetails.product?.price ?? '0') ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text(
                '\$${(basePrice * quantity).toStringAsFixed(1)}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              )
            ],
          ),
          SizedBox(
            width: 140,
            child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  return Visibility(
                    visible: !addToCartController.inProgress,
                    replacement: CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapAddToCart,
                      child: const Text('Added To cart ', style: TextStyle(
                          fontSize: 18,
                      ),),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapAddToCart() async {
    bool isLoggedInUser = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      AuthController.accessToken;
      final result = await Get.find<AddToCartController>().getAddToCart(
          CartModel(
              productId: widget.productId,
              color: _selectedColor,
              size: _selectedSize,
              quantity: quantity
          ));
      if (result) {
        ShowSnackBarMessage(context, 'Added to cart Successfully');
        Get.to(() => CartListScreen());  //Navigate to cart screen
        /*showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('Item Added to Cart'),
                content: Text(
                    'Do you want to view your cart or continue shopping?'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(), // Close dialog
                    child: Text('Continue Shopping'),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => CartListScreen()),
                    child: Text('View Cart'),
                  ),
                ],
              ),);

         */
      } else {
        ShowSnackBarMessage(context, 'you need to first login!');
        Get.to(() => const EmailVerificationScreen());
      }
    }
  }
}