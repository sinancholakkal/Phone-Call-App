import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone/presentation/pages/screen_contact_edit/screen_contact_edit.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/contact_info_section.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/delete_and_action_section.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/profile_and_action_section.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/icon_button_widget.dart';

class ScreenContactView extends StatelessWidget {
  const ScreenContactView({
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
        actionsPadding: EdgeInsets.only(right: 30),
        backgroundColor: Colors.transparent,
        actions: [
          IconButtonWidget(icon: Icon(Icons.edit), onTap:()=>Get.to(()=>ScreenContactEdit(contact: contact,color: color,))),
          SizedBox(width: 20),
          IconButtonWidget(
            icon: Icon(
              (contact.isStared == true) ? Icons.star : Icons.star_border,
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Profile and call message icon button--------------
          ProfileAndActionSection(contact: contact, color: color),
          //Contact info----------
          ContactInfoSection(contact: contact),
          //Delete----------
          DeleteAndActionSection(),
        ],
      ),
    );
  }
}


