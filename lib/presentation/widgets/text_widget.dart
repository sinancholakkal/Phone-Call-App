import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
   TextWidget({super.key, required this.text,  this.color,  this.fontSize,  this.fontWeigh, this.padding=const EdgeInsets.all(0)});
   final String text;
   final Color? color;
   final double? fontSize;
   final FontWeight? fontWeigh;
   final EdgeInsetsGeometry padding;
   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(text,style: TextStyle(color: color,fontSize: fontSize,fontWeight:fontWeigh, ),),
    );
  }
}