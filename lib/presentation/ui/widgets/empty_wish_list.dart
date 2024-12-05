import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWishList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/wishlist.json',
                  width: 250,
                  height: 250,
                  fit: BoxFit.scaleDown
              ),
              //SizedBox(height: 7,),
              Text('Empty Wish List',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),)
            ],
        ),
      );
  }


}