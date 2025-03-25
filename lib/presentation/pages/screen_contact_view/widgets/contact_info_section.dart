
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/dialer_screen_bloc/dialer_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key, required this.contact});

  final ContactInfo contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: const Color.fromARGB(255, 47, 35, 30),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextWidget(
                    text: "Contact info",
                    fontSize: 16,
                    fontWeigh: FontWeight.bold,
                  ),
                ),
                InkWell(
                  splashColor: Colors.black,
                  onTap: () {
                    context.read<DialerBloc>().add(
                      MakeCallEvent(
                        phone: contact.phone.first.number,
                        context: context,
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.call),
                    title: TextWidget(
                      text:
                          contact.phone.isNotEmpty
                              ? contact.phone.first.number
                              : "No phone",
                      fontSize: 18,
                      fontWeigh: FontWeight.bold,
                    ),
                    subtitle: TextWidget(text: "Phone"),
                    //s trailing: IconButtonWidget(icon: Icon(Icons.message)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}