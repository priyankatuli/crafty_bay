import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {

  SearchTextField({super.key, required this.textEditingController,});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          )
      ),
    );
  }
}