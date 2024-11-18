import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../utils/assets_path.dart';

class CartItemScreen extends StatefulWidget {
  CartItemScreen({
    super.key,
    required this.cartItem,

  });

  final CartItemModel cartItem;

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {

  late int _counterValue;

  void initState(){
    super.initState();
    //_counterValue = widget.cartItem.qty! as int;
    _counterValue = int.tryParse(widget.cartItem.qty ?? '1') ?? 1;
  }
  @override
  Widget build(BuildContext context) {

    Future<bool> _initialize()async{
      bool check = await Get.find<CartListController>().getCartList();
      if(check == false){
        showSnackBarMessage(context, 'Please login!');
        Get.to(() => EmailVerificationScreen());
      }
      return check;
    }
    //final cartListController = Get.find<CartListController>().deleteCartList(widget.cartItem.id!);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        elevation: 3,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Row(
          children: [
            _buildProductImage(),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.cartItem.product?.title ?? 'No product title found',style: textTheme.bodyLarge,),
                            _buildColorAndSize(textTheme)
                          ],
                        ),
                      ),
                      GetBuilder<CartListController>(
                        builder: (cartListController) {
                          return IconButton(
                              onPressed: () async {
                            bool result = await cartListController.deleteCartList(widget.cartItem.id!);
                            if (result) {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, 'Delete cart list successfully');
                                setState(() {
                                  //_initialize(); //refetch cart list or update UI
                                });
                              }
                            } else {
                              showSnackBarMessage(context, 'Please login!');
                              //showSnackBarMessage(context, CartListController().errorMessage ?? '');
                              Get.to(() => const EmailVerificationScreen());
                            }
                          }
                              , icon: Icon(Icons.delete, color: Colors.grey,));
                        }
                      )
                    ],
                  ),
                  _buildPriceAndCountSection(textTheme,context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
                          spacing: 8,
                          children: [
                            Text(widget.cartItem.color ?? '',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                            Text(widget.cartItem.size ?? '',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                          ],
                        );
  }

  Widget _buildPriceAndCountSection(TextTheme textTheme,BuildContext context) {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${widget.cartItem.product?.price ?? ''}',style: textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor
                  )),
                  ItemCount(
                    initialValue: _counterValue,
                    minValue: 1,
                    maxValue: 20,
                    decimalPlaces: 0,
                    color: AppColors.themeColor,
                    onChanged: (value) async {
                       setState(() {
                         _counterValue = value as int;
                       });

                       // Update cart item quantity if needed
                       widget.cartItem.qty = _counterValue.toString();
                       await Get.find<CartListController>().getCartList(); //refetch cart list or update UI

                    },
                  ),
                ],
              );
  }

  Widget _buildProductImage() {
    return Container(
          //padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    widget.cartItem.product?.image ?? AssetsPath.dummyProductImage),
                fit: BoxFit.scaleDown,
              ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )
          ),
          height: 80,
          width: 80,
        );

    }

}
