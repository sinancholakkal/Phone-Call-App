import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ScreenContactEdit extends StatelessWidget {
  const ScreenContactEdit({
    super.key,
    required this.contact,
    required this.color,
  });
  final ContactInfo contact;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Edit contact"),
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            ),
            child: TextWidget(text: "Save", color: Colors.black),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: (contact.image == null) ? color : null,
              radius: 70,
              backgroundImage:
                  (contact.image != null) ? MemoryImage(contact.image!) : null,
              child:
                  (contact.image == null)
                      ? TextWidget(
                        text: contact.displayName[0].toUpperCase(),
                        fontSize: 90,
                        fontWeigh: FontWeight.bold,
                      )
                      : null,
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                IconWithTextButtonWidgetH(
                  icon: Icons.edit,
                  text: "Change",
                  onTap: () {},
                ),
                IconWithTextButtonWidgetH(
                  icon: Icons.delete,
                  text: "Remove",
                  onTap: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
