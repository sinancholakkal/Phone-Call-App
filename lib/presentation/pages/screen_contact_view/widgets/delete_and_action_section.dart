import 'package:flutter/material.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class DeleteAndActionSection extends StatelessWidget {
  const DeleteAndActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red[300]),
              title: TextWidget(text: "Delete", color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
