import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProductImageSlider extends StatefulWidget{

  ProductImageSlider({super.key,required this.sliderUrls});

  @override
  State<StatefulWidget> createState() {
      return _ProductImageSliderState();
  }

  final List<String> sliderUrls;

}

class _ProductImageSliderState extends State<ProductImageSlider>{

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
      return Stack(
          children: [ CarouselSlider(
            options: CarouselOptions(
                height: 220,
                //autoPlay: true,
                //autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index,reason){
                  _selectedIndex.value = index;
                },
              viewportFraction: 1,

            ),
            items: widget.sliderUrls.map((imageUrls) {
              return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      //margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        image: DecorationImage(
                            image: NetworkImage(imageUrls),
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
                        for(int i=0;i<widget.sliderUrls.length;i++)
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