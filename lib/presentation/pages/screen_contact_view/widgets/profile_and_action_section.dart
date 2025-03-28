
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:phone/presentation/bloc/dialer_screen_bloc/dialer_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/icon_with_text.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ProfileAndActionSection extends StatelessWidget {
  const ProfileAndActionSection({
    super.key,
    required this.contact,
    required this.color,
    required this.contactInfo
  });

  final ContactInfo contactInfo;
  final Color color;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: (contact.photoOrThumbnail == null) ? color : null,
            radius: 100,
            backgroundImage:
                (contact.photoOrThumbnail != null) ? MemoryImage(contact.photoOrThumbnail!) : null,
            child:
                (contact.photoOrThumbnail == null)
                    ? TextWidget(
                      text: contact.displayName[0].toUpperCase(),
                      fontSize: 90,
                      fontWeigh: FontWeight.bold,
                    )
                    : null,
          ),
          SizedBox(height: 10),
          TextWidget(text: contact.displayName, fontSize: 22),
          SizedBox(height: 20),

          //Call and message icon buttons--------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconWIthTextWidget(
                icon: InkWell(
                  onTap: () {
                    context.read<DialerBloc>().add(
                      MakeCallEvent(
                        phone: contact.phones.first.number,
                        context: context,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 25,
                    child: Icon(Icons.call, size: 30),
                  ),
                ),
                text: "Call",
              ),
              IconWIthTextWidget(
                icon: InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 25,
                    child: Icon(Icons.message, size: 30),
                  ),
                ),
                text: "Message",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
