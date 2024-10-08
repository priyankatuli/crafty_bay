import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_project/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProductImageSlider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _ProductImageSliderState();
  }

}

class _ProductImageSliderState extends State<ProductImageSlider>{

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
      return Stack(
          children: [ CarouselSlider(
            options: CarouselOptions(
                height: 220,
                onPageChanged: (index,reason){
                  _selectedIndex.value = index;
                },
              viewportFraction: 1,

            ),
            items: [1, 2, 3, 4, 5, 6].map((i) {
              return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      //margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.dummyProductImage),
                        )
                      ),
                      //alignment: Alignment.center,
                      //child: Text('text $i', style: TextStyle(fontSize: 16),),
                    );
                  }
              );
            }).toList(),

          ),
            //change howar sathe sathe valueListenableBuilder rebuild hocche
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context,currentIndex,_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(int i=0;i<6;i++)
                          Container(
                            height: 12,
                            width: 12,
                            margin: EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: _selectedIndex.value == i ? AppColors.themeColor : Colors.white,
                              borderRadius: BorderRadius.circular(12),

                            ),
                          ),
                      ],
                    );
                  }
              ),
            ),

          ]
      );
  }

}