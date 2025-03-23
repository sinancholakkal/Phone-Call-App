import 'dart:developer';
import 'dart:typed_data';

import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/tab_contacts_bloc/tab_contacts_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/widgets/add_new_contact.dart';
import 'package:phone/presentation/widgets/circular_indicator_widget.dart';
import 'package:phone/presentation/widgets/search_section.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ContactInfo extends ISuspensionBean {
  final String displayName;
  String? tagIndex;
  final Uint8List? image;

  ContactInfo({required this.displayName, required this.image});

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

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (var item in list) {
      if (item.displayName != "") {
        String tag =
            item.displayName.isNotEmpty
                ? item.displayName[0].toUpperCase()
                : '#';
        item.tagIndex = tag;
      }
    }
    list.sort((a, b) => a.getSuspensionTag().compareTo(b.getSuspensionTag()));
    SuspensionUtil.setShowSuspensionStatus(list);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SearchSection(),
        const AddNewContactSection(),
        Expanded(
          child: BlocBuilder<TabContactsBloc, TabContactsState>(
            builder: (context, state) {
              if (state is FetchAllContactsLoadingState) {
                return const CircularIndicatorWidget();
              } else if (state is FetchAllContactsLoadedState) {
                if (state.contacts.isEmpty) {
                  return Center(child: TextWidget(text: "No contacts"));
                } else {
                  // Convert state.contacts to List<ContactInfo>
                  for (var c in state.contacts) {
                    log(c.name.toString());
                  }
                  final contacts =
                      state.contacts
                          .where(
                            (contact) =>
                                contact.displayName != "" &&
                                contact.displayName.isNotEmpty,
                          ) // Filter out null or empty displayName
                          .map(
                            (contact) => ContactInfo(
                              displayName: contact.displayName,
                              image: contact.photoOrThumbnail,
                            ),
                          ) // Map to ContactInfo
                          .toList();
                  _handleList(contacts); // Prepare the list

                  return AzListView(
                    data: contacts,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      // Add section header logic
                      final showHeader =
                          index == 0 ||
                          contact.getSuspensionTag() !=
                              contacts[index - 1].getSuspensionTag();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader)
                            Container(
                              width: double.infinity,
                              color: const Color.fromARGB(255, 37, 35, 35),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                contact.getSuspensionTag(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ListTile(
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
                        ],
                      );
                    },
                    indexBarOptions: const IndexBarOptions(
                      needRebuild: true,
                      hapticFeedback: true,
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    physics: const BouncingScrollPhysics(),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
