import 'package:flutter/material.dart';

class CompleteUserProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _CompleteUserProfileScreen();
  }
  
}

class  _CompleteUserProfileScreen extends State<CompleteUserProfileScreen>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Profile'),
         backgroundColor: Colors.grey.shade200,
         foregroundColor: Colors.black26,
       ),
       body: SingleChildScrollView(
         child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
           child: Column(
             children: [
               SizedBox(height: 10,),
               TextFormField(
                 //controller: _firstNameTEController,
                 decoration: InputDecoration(
                   hintText: 'FirstName',
                 ),
                 keyboardType: TextInputType.text,
                 autovalidateMode: AutovalidateMode.onUserInteraction,
               )
             ],
           ),
         ),
       ),
     );
  }
  
}