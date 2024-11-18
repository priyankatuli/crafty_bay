import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: GridView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    elevation: 3,
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        children: [
                          Container(
                            width: 160,
                            height: 100,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 8,
                 mainAxisExtent: 8
              ),
            ),);
          }
  }
