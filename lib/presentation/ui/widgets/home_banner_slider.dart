import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/slider_model.dart';
import 'package:crafty_bay/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  // late final TextTheme textTheme = Theme.of(context).textTheme;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: sliderListController.inProgress == false,
        replacement: SizedBox(
          height: 192,
          child: CenteredProgressIndicator(),
        ),
        child: Column(
            children: [
              _buildCarouselSlider(sliderListController),
              const SizedBox(height: 8,),
              //change howar sathe sathe valueListenableBuilder rebuild hocche
              _buildCarouselDotsSlider(sliderListController),
            ]
        ),
      );
    });
  }

  Widget _buildCarouselSlider(SliderListController sliderListController) {
    return CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                height: 182,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  _selectedIndex.value = index;
                }
            ),
            items: sliderListController.sliderList.map((sliders) {
              return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery
                          .of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          //color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(sliders.image ?? '',
                              ),
                            fit: BoxFit.cover
                          )
                    ),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextAndButtonSection(sliders, context),

                        ],
                      )
                    );
                  }
              );
            }).toList(),
          );
  }

  Widget _buildTextAndButtonSection(SliderModel sliders, BuildContext context) {
    return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(sliders.price ?? '',
                 textAlign: TextAlign.center,
                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
                     color: Colors.black,
                     fontWeight: FontWeight.w500
                 )),
             const SizedBox(height: 8,),
             SizedBox(
                 width: 100,
                 child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.white,
                         foregroundColor: Colors.black
                     ),
                     onPressed: (){},
                     child: Text('Buy Now',)))
           ],
         )
    );
  }

  Widget _buildCarouselDotsSlider(SliderListController sliderListController) {
    return ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, currentIndex, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i = 0; i < sliderListController.sliderList.length; i++)
                        Container(
                          height: 12,
                          width: 12,
                          margin: EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: _selectedIndex.value == i ? AppColors
                                .themeColor : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey
                            ),
                          ),
                        ),
                    ],
                  );
                }
            );
  }

  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}


