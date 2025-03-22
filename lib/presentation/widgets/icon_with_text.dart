import 'package:flutter/material.dart';

class IconWIthTextWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  const IconWIthTextWidget({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [icon, Text(text)]);
  }
}
