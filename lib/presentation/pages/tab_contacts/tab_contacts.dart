import 'dart:typed_data';
import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phone/presentation/bloc/tab_contacts_bloc/tab_contacts_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/widgets/add_new_contact.dart';
import 'package:phone/presentation/pages/tab_contacts/widgets/contact_item_display_section.dart';
import 'package:phone/presentation/widgets/search_section.dart';

class ContactInfo extends ISuspensionBean {
  final String displayName;
  String? tagIndex;
  final Uint8List? image;
  final bool isStared;
  final List<Phone>phone;
  final String firstName;
  final String lastName;
  final String contactId;

  ContactInfo({required this.displayName, required this.image,required this.isStared,required this.phone,required this.firstName,required this.lastName,required this.contactId});

  @override
  String getSuspensionTag() => tagIndex ?? '';
}

class TabContacts extends StatefulWidget {
  const TabContacts({super.key});

  @override
  State<TabContacts> createState() => _TabContactsState();
}

class _TabContactsState extends State<TabContacts> {
  Future<void> getContacts() async {
    context.read<TabContactsBloc>().add(FetchAllContactsEvent());
  }

  @override
  void initState() {
    context.read<TabContactsBloc>().add(FetchAllContactsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Search Section-----------
        const SearchSection(),
        //Add new contact section------------
        const AddNewContactSection(),
        //contact display section----------------
        ContactItemsDisplaySection(),
      ],
    );
  }
}
