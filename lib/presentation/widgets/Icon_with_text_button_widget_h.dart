import 'package:flutter/material.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class IconWithTextButtonWidgetH extends StatelessWidget {
  IconWithTextButtonWidgetH({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });
  void Function() onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Icon(icon),
            TextWidget(text: text, padding: EdgeInsets.all(12)),
          ],
        ),
      ),
    );
  }
}
