
import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget{

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  TextEditingController _firstNameTEController = TextEditingController();

  TextEditingController _lastNameTEController = TextEditingController();

  TextEditingController _reviewsTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Create Reviews'),
            backgroundColor: Colors.grey.shade200,
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                    hintText: 'FirstName',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                    hintText: 'LastName',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _reviewsTEController,
                  decoration: InputDecoration(
                    hintText: 'Write Reviews',
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                 maxLines: 10,
                ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: (){

                }, child: Text('Submit'))
              ],
            ),
          ),
        )
      );
  }
  void dispose(){
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _reviewsTEController.dispose();
    super.dispose();
  }
}