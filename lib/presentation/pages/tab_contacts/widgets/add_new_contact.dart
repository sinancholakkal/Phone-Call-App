import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class AddNewContactSection extends StatelessWidget {
  const AddNewContactSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
    
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Icon(
              Icons.group_add_sharp,
              color: Colors.lightBlueAccent,
              size: 26,
            ),
            TextWidget(
              text: "Create new contact",
              color: Colors.lightBlueAccent,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
