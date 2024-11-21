import 'package:crafty_bay/data/models/payment_method.dart';
import 'package:crafty_bay/presentation/state_holders/payment_method_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_gateway_webview.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _PaymentDetailsScreenState();
  }

}
class _PaymentDetailsScreenState extends State<PaymentDetailsScreen>{

  void initState(){
    super.initState();
    Get.find<PaymentMethodListController>().getPaymentMethod();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Payment Details'),
       ),
       body: GetBuilder<PaymentMethodListController>(
         builder: (paymentMethodListController){
           if(paymentMethodListController.inProgress){
             return CenteredProgressIndicator();
           }
           if(paymentMethodListController.errorMessage != null){
             return Center(
               child: Text(paymentMethodListController.errorMessage!),
             );
           }
           return SingleChildScrollView(
             child: Padding(
                   padding: EdgeInsets.all(16),
                   child: Column(
                       children: [
                         _buildMethodSummeryRow(
                           title: 'Total',
                           amount: '100000',
                         ),
                         _buildMethodSummeryRow(title: 'VAT',
                             amount: '${paymentMethodListController.paymentMethodResponseData?.vat}'),
                         _buildMethodSummeryRow(
                             title: 'Total Payable', amount: '${paymentMethodListController.paymentMethodResponseData?.payable}'),
                         SizedBox(height: 16,),
                         ListView.separated(
                             primary: false,
                             shrinkWrap: true,
                             itemCount: paymentMethodListController.paymentMethodResponseData?.paymentMethod?.length ?? 0,
                             itemBuilder: (context, index) {

                               final PaymentMethod paymentMethod = paymentMethodListController.paymentMethodResponseData!.paymentMethod![index];
                               return ListTile(

                                 title: Text(paymentMethod.name ?? ''),
                                 leading: Image.network(paymentMethod.logo ?? ''),
                                 trailing: Icon(Icons.arrow_forward),
                                 onTap: (){
                                   Get.to(() => PaymentGatewayWebView(gatewayUrl: paymentMethod.redirectGatewayURL ?? '',));
                                 },
                               );
                             }, separatorBuilder: (_, __) {
                               return const SizedBox(height: 10,);
                         },)
                       ]
                   ),
             ),
           );
         }
       ),
     );
  }

  Widget _buildMethodSummeryRow({required String title, required String amount}) {
    return Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                    Text(title),
                    Text('\$$amount')
       ],
           );
  }

}