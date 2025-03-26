import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone/presentation/bloc/contact_edit_screen_bloc/contact_edit_screen_bloc.dart';
import 'package:phone/presentation/bloc/tab_contacts_bloc/tab_contacts_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/Icon_with_text_button_widget_h.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ScreenContactEdit extends StatefulWidget {
  const ScreenContactEdit({
    super.key,
    required this.contactId,
    required this.color,
    required this.contact,
  });
  final String contactId;
  final Color color;
  final ContactInfo contact;

  @override
  State<ScreenContactEdit> createState() => _ScreenContactEditState();
}

class _ScreenContactEditState extends State<ScreenContactEdit> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late ContactEditScreenBloc _bloc;
  late bool isImgRemoved = true;
  Uint8List? imageBytes;
  Contact? contact;
  @override
  void initState() {
    context.read<TabContactsBloc>().add(
      FecthOneContactEvent(contactId: widget.contactId),
    );
    isImgRemoved = widget.contact.image != null ? false : true;
    _bloc = context.read<ContactEditScreenBloc>();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.add(ResetImageEvent());
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Edit contact"),
        backgroundColor: Colors.transparent,
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // Contact? contact = await FlutterContacts.getContact(widget.contact.contactId,withAccounts: true);
              // if(contact!=null){
              //   contact.name.first = _firstNameController.text.trim();
              //   //contact.name.last = _lastNameController.text.trim();
              //   await contact.update();
              //   log("Contact updated");
              // }

              context.read<ContactEditScreenBloc>().add(
                ContactEditEvent(
                  firstName: _firstNameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  imageByte: imageBytes,
                  contact: contact!,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            ),
            child: TextWidget(text: "Save", color: Colors.black),
          ),
        ],
      ),
      body: BlocListener<ContactEditScreenBloc, ContactEditScreenState>(
        listener: (context, state) {
          if (state is ContactEditLoadedState) {
            context.read<TabContactsBloc>().add(
              FecthOneContactEvent(contactId: widget.contactId),
            );
            Get.back();
          }
        },
        child: BlocBuilder<TabContactsBloc, TabContactsState>(
          builder: (context, cState) {
            if (cState is FetchOneContactLoaded) {
              contact = cState.contact;
              _firstNameController.text =
                  cState.contact.name.first.isEmpty
                      ? ""
                      : cState.contact.name.first;

              _lastNameController.text =
                  cState.contact.name.last.isEmpty
                      ? ""
                      : cState.contact.name.last;
              _phoneController.text = cState.contact.phones.first.number;

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    // spacing: 10,
                    children: [
                      SizedBox(height: 20),
                      BlocBuilder<
                        ContactEditScreenBloc,
                        ContactEditScreenState
                      >(
                        builder: (context, state) {
                          if (state is ImagePickLoadedState &&
                              state.imageByte != null) {
                            isImgRemoved = false;
                            imageBytes = state.imageByte;
                          }
                          return CircleAvatar(
                            backgroundColor:
                                (cState.contact.photoOrThumbnail == null ||
                                        isImgRemoved == true)
                                    ? widget.color
                                    : null,
                            radius: 70,
                            backgroundImage:
                                (isImgRemoved == false)
                                    ? _getBackgroundImage(
                                      state,
                                      cState.contact.photoOrThumbnail,
                                    )
                                    : null,
                            child:
                                (cState.contact.photoOrThumbnail == null &&
                                            (state is! ImagePickLoadedState) ||
                                        isImgRemoved == true)
                                    ? TextWidget(
                                      text:
                                          cState.contact.displayName[0]
                                              .toUpperCase(),
                                      fontSize: 90,
                                      fontWeigh: FontWeight.bold,
                                    )
                                    : null,
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 25,
                        children: [
                          IconWithTextButtonWidgetH(
                            icon: Icons.edit,
                            text: "Change",
                            onTap: () async {
                              context.read<ContactEditScreenBloc>().add(
                                ImagePickEvent(),
                              );
                            },
                          ),
                          IconWithTextButtonWidgetH(
                            icon: Icons.delete,
                            text: "Remove",
                            onTap: () {
                              _bloc.add(ResetImageEvent());
                              setState(() {
                                isImgRemoved = true;
                                imageBytes = null;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          spacing: 15,
                          children: [
                            TextFieldWidget(
                              screeWidth: screeWidth,
                              controller: _firstNameController,
                              labelText: "First name",
                            ),

                            TextFieldWidget(
                              screeWidth: screeWidth,
                              controller: _lastNameController,
                              labelText: "Last name",
                            ),
                            TextFieldWidget(
                              screeWidth: screeWidth,
                              controller: _phoneController,
                              labelText: "Phone",
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  ImageProvider? _getBackgroundImage(
    ContactEditScreenState state,
    dynamic photoOrThumbnail,
  ) {
    if (state is ImagePickLoadedState && state.imageByte != null) {
      return MemoryImage(state.imageByte!);
    } else if (photoOrThumbnail != null) {
      return MemoryImage(photoOrThumbnail!);
    }
    return null;
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.screeWidth,
    this.controller,
    required this.labelText,
    this.keyboardType,
  });

  final double screeWidth;
  final TextEditingController? controller;
  final String labelText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screeWidth * 0.8,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(labelText),
        ),
      ),
    );
  }
}
