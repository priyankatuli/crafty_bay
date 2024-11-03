import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    super.key, required this.onTap, required this.iconData,
  });

  final VoidCallback onTap;
  final IconData iconData;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 20,
            child: Icon(
              iconData,
              //color: Colors.grey.shade200,
              size: 20,
            ),
          ),
    );
  }
}