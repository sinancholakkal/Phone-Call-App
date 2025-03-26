import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:phone/presentation/bloc/tab_contacts_bloc/tab_contacts_bloc.dart';
import 'package:phone/presentation/pages/screen_contact_edit/screen_contact_edit.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/contact_info_section.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/delete_and_action_section.dart';
import 'package:phone/presentation/pages/screen_contact_view/widgets/profile_and_action_section.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/icon_button_widget.dart';

class ScreenContactView extends StatefulWidget {
  const ScreenContactView({
    super.key,
    required this.contact,
    required this.color,
  });
  final ContactInfo contact;
  final Color color;

  @override
  State<ScreenContactView> createState() => _ScreenContactViewState();
}

class _ScreenContactViewState extends State<ScreenContactView> {

  @override
  void initState() {
    context.read<TabContactsBloc>().add(FecthOneContactEvent(contactId: widget.contact.contactId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 30),
        backgroundColor: Colors.transparent,
        actions: [
          IconButtonWidget(
            icon: Icon(Icons.edit),
            onTap:
                () => Get.to(
                  () => ScreenContactEdit(
                    contactId: widget.contact.contactId,
                    color: widget.color,
                    contact: widget.contact,
                  ),
                ),
          ),
          SizedBox(width: 20),
          IconButtonWidget(
            icon: Icon(
              (widget.contact.isStared == true) ? Icons.star : Icons.star_border,
            ),
            onTap: () {},
          ),
        ],
      ),
      body: BlocBuilder<TabContactsBloc, TabContactsState>(
        builder: (context, state) {
          if(state is FetchOneContactLoaded){
            return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Profile and call message icon button--------------
              ProfileAndActionSection(contactInfo: widget.contact, color: widget.color,contact: state.contact,),
              //Contact info----------
              ContactInfoSection(contact: widget.contact),
              //Delete----------
              DeleteAndActionSection(),
            ],
          );
          }
          return SizedBox();
        },
      ),
    );
  }
}
