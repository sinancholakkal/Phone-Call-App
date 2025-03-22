import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
   TextWidget({super.key, required this.text,  this.color,  this.fontSize,  this.fontWeigh});
   final String text;
   final Color? color;
   final double? fontSize;
   final FontWeight? fontWeigh;
   

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize,fontWeight:fontWeigh ),);
  }
}