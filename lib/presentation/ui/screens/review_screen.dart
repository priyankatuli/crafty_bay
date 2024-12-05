
import 'package:crafty_bay/data/models/review_screen_data.dart';
import 'package:crafty_bay/presentation/state_holders/review_screen_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget{

  final ReviewScreenController controller = Get.find<ReviewScreenController>();


  @override
  Widget build(BuildContext context) {
     return Scaffold(
           backgroundColor: Colors.grey.shade200,
           appBar: AppBar(
             title: Text('Reviews')
           ),
        body: GetBuilder<ReviewScreenController>(
          builder: (reviewScreenController) {

            if(reviewScreenController.inProgress){
              return CenteredProgressIndicator();
            }
            if(reviewScreenController.errorMessage != null){
              return Center(
                child: Text(reviewScreenController.errorMessage!),
              );
            }
            if(reviewScreenController.reviewScreenDataList == null || reviewScreenController.reviewScreenDataList!.isEmpty){
                 return Center(
                   child: Text('No reviews available'),
                 );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.reviewScreenDataList?.length,
                      itemBuilder: (context, index) {
                        final review =  controller.reviewScreenDataList?[index];
                        print("Rendering review: $review");
                        return Card(
                          elevation: 1,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildIconAndTextSection(context,review!),
                                const SizedBox(height: 6,),
                                _buildDescriptionSection(context,review),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                _buildReviewsAndCreateReviewSection(),
              ],
            );
          }
        ),
     );
  }

  Widget _buildDescriptionSection(BuildContext context,ReviewScreenData review) {
             return Row(
                 children: [
                   Expanded(
                     child: Text(review.description ?? 'No description found',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    color: Colors.black54
                            ), softWrap: true,
                     ),
                   ),
                 ]
             );
  }

  Widget _buildIconAndTextSection(BuildContext context,ReviewScreenData review) {
                        return Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 CircleAvatar(
                                   minRadius: 13,
                                   backgroundColor: Colors.grey.shade400,
                                   child: Icon(Icons.person_2_outlined,color: Colors.white,size: 16,),
                                 ),
                                 const SizedBox(width: 16,),
                                 Text(review.profile?.cusName ?? '',
                                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                         color: Colors.black87,
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500
                                     )
                                 ),
                               ],
                        );
  }


  Widget _buildReviewsAndCreateReviewSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total reviews : ${controller.reviewScreenDataList?.length}',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
                   Get.to(() => CreateReviewScreen());
            },
            child: CircleAvatar(
              backgroundColor: AppColors.themeColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add,color: Colors.white,size: 20,),
              ),
            ),
          )
        ],
      ),
    );
  }

}