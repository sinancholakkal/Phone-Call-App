import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
   IconButtonWidget({
    super.key,
    required this.icon,
    this.onTap
  });
  final Widget icon;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: icon,
      ),
    );
  }
}