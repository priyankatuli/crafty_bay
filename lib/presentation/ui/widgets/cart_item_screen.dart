import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/show_snack_bar_message.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import '../utils/assets_path.dart';

class CartItemScreen extends StatefulWidget {
  CartItemScreen({
    super.key,
    required this.cartItem,
    required this.index
  });

  final CartItemModel cartItem;
  final int index;


  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {

  late int _counterValue;

  void initState(){
    _counterValue = int.tryParse(widget.cartItem.qty ?? '1') ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
              elevation: 3,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  _buildProductImage(),
                  Expanded(
                    child: GetBuilder<CartListController>(
                      builder: (cartListController) {
                        return Visibility(
                          visible: cartListController.inProgress == false,
                          replacement: CenteredProgressIndicator(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(widget.cartItem.product?.title ??
                                            'No product title found',
                                          style: textTheme.bodyLarge,),
                                        _buildColorAndSize(textTheme)
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                          bool result = await cartListController.deleteCartList(widget.cartItem.productId ?? 0);
                                          if (result) {
                                              ShowSnackBarMessage(context,
                                                  'Delete cart list successfully');
                                          }
                                          else {
                                            ShowSnackBarMessage(
                                                context,
                                                'Failed to delete cart item.Please login!');
                                            Get
                                                .to(() => const EmailVerificationScreen());
                                          }
                                        },
                                      icon: Icon(
                                        Icons.delete, color: Colors.grey,)),
                                ],
                              ),
                              _buildPriceAndCountSection(textTheme, context),
                            ],
                          ),
                        );
                      }
                    ),
              ),
        ]
            ),
    );
        }


  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
                          spacing: 8,
                          children: [
                            Text('Color : ${widget.cartItem.color ?? 'No color selected'}',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                            Text('Size: ${widget.cartItem.size ?? 'No size selected'}',style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey
                            ),),
                          ],
                        );
  }

  Widget _buildPriceAndCountSection(TextTheme textTheme,BuildContext context) {

    final int unitPrice = int.tryParse(widget.cartItem.product?.price ?? '0') ?? 0;
    final int itemPrice = unitPrice * _counterValue;

    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('\$${itemPrice.toString()}',
                style: textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor
                  )),
                  ItemCount(
                    initialValue: _counterValue, //set initial value from the controller
                    minValue: 1,
                    maxValue: 20,
                    decimalPlaces: 0,
                    color: AppColors.themeColor,
                    onChanged: (value) async {
                      if(mounted) {
                        setState(() {
                          _counterValue = value as int;
                        });
                          //Update the quantity in the cart item
                        }
                    Get.find<CartListController>().updateQuantity(widget.cartItem.productId!, _counterValue);
                      }
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
                    '${widget.cartItem.product?.image ?? AssetsPath.dummyProductImage}'),
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
