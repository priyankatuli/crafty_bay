import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/empty_cart_list.json',height: 250,width: 250,fit: BoxFit.scaleDown),
            const SizedBox(height: 7,),
            Text('Cart List Empty',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            )
          ],
        ),
      );
  }
  
}