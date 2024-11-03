import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return PopScope(
       canPop: false,
       onPopInvokedWithResult: (value,_){
         Get.back();
       },
       child: Scaffold(
         backgroundColor: Colors.grey.shade200,
         appBar: AppBar(
           title: Text('Reviews'),
           leading: IconButton(onPressed: (){
                Get.back();
           }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.grey,))
         ),

      body: Column(
               children: [
                 Expanded(
                     child: ListView.builder(
                       itemCount: 5,
                         itemBuilder: (context,index){
                            return Card(
                              elevation: 1,
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    _buildIconAndTextSection(context),
                                    const SizedBox(height: 6,),
                                    _buildDescriptionSection(context),
                                  ],
                                ),
                              ),
                            );
                       }
                 ),
               ),
               _buildReviewsAndCreateReviewSection(),
               ],
             ),
      ),);
  }

  Widget _buildDescriptionSection(BuildContext context) {
             return Row(
                 children: [
                   Expanded(
                     child: Text('This is the description of review section when you review this application we can understand that whats the problem you are facing.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    color: Colors.black54
                            ), softWrap: true,
                     ),
                   ),
                 ]
             );
  }

  Widget _buildIconAndTextSection(BuildContext context) {
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
                                 Text('Tuli',
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
              Text('Reviews(1000)',
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