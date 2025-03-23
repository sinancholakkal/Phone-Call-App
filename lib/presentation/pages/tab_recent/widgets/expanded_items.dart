import 'package:flutter/material.dart';
import 'package:phone/presentation/widgets/icon_with_text.dart';

class ExpandableRow extends StatefulWidget {
  final bool isExpanded;
  const ExpandableRow({required this.isExpanded});

  @override
  State<ExpandableRow> createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow> {
  bool showIcons = false;

  @override
  void didUpdateWidget(covariant ExpandableRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isExpanded && !oldWidget.isExpanded) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (mounted && widget.isExpanded) {
          setState(() {
            showIcons = true;
          });
        }
      });
    } else if (!widget.isExpanded) {
      setState(() {
        showIcons = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.isExpanded ? 100 : 0,
      child:
          showIcons
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWIthTextWidget(
                    icon: Icon(Icons.person_add_alt_outlined),
                    text: "Add contact",
                  ),
                  IconWIthTextWidget(
                    icon: Icon(Icons.message_outlined),
                    text: "Message",
                  ),
                  IconWIthTextWidget(
                    icon: Icon(Icons.history),
                    text: "History",
                  ),
                ],
              )
              : SizedBox.shrink(),
    );
  }
}