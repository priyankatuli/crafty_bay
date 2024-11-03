
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
             Lottie.asset(
               'assets/lotties/empty_list.json',
               height: 200,
               width: 200,
               fit: BoxFit.scaleDown
             ),
           SizedBox(height: 7,),
           Text('No products available!',
             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
               fontWeight: FontWeight.w400
             )
           )
         ],
       ),
    );
  }

}