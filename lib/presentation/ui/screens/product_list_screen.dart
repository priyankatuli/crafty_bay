
import 'package:flutter/material.dart';


class ProductListScreen extends StatelessWidget{

  ProductListScreen({super.key,required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
           title: Text(categoryName),

         ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: GridView.builder(
                itemCount: 20,
                  itemBuilder: (context,index){
                      //return ProductCard();
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8
                  )
              ),
        ),
      );
  }
}