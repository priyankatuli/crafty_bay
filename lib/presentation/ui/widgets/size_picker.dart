
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget{

  final List<String> sizes;
  final Function(String) onSizedSelected;

  const SizePicker({super.key, required this.sizes, required this.onSizedSelected});


  @override
  State<StatefulWidget> createState() {
     return _SizePickerState();
  }
}

class _SizePickerState extends State<SizePicker>{

  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text('Size',style: Theme.of(context).textTheme.titleLarge,),
         const SizedBox(height: 8,),
         Wrap(
           spacing: 8,
           children: widget.sizes.map((item){
               return GestureDetector(
                 onTap: (){
                    _selectedSize = item;
                    widget.onSizedSelected(item);
                    setState(() {

                    });
                 },
                 child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 8),
                   decoration: BoxDecoration(
                     border: Border.all(),
                     color: _selectedSize == item ? AppColors.themeColor : null
                   ),
                   child: Text(item,
                     style: TextStyle(
                       fontSize: 18,
                       color: _selectedSize ==  item ? Colors.white : null
                     ),
                   )
                 ),
               );
           }).toList(),
         )
       ],

     );
  }

}