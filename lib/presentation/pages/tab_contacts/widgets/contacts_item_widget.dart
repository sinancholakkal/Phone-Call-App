
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone/presentation/pages/screen_contact_view/screen_contact_view.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ContactsItemWidget extends StatelessWidget {
  const ContactsItemWidget({
    super.key,
    required this.contact,
    required this.index,
  });
  final int index;
  final ContactInfo contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>ScreenContactView(contact: contact,color: Colors.primaries[index %
                          Colors.primaries.length],),transition: Transition.rightToLeft,);
      },
      child: ListTile(
        leading:
            (contact.image != null)
                ? CircleAvatar(
                  backgroundImage: MemoryImage(
                    contact.image!,
                  ),
                )
                : CircleAvatar(
                  backgroundColor:
                      Colors.primaries[index %
                          Colors.primaries.length],
                  child: Center(
                    child: TextWidget(
                      text:
                          contact.displayName[0]
                              .toUpperCase(),
                    ),
                  ),
                ),
        title: TextWidget(text: contact.displayName),
      ),
    );
  }
}
