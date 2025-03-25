import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone/presentation/bloc/contact_edit_screen_bloc/contact_edit_screen_bloc.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/widgets/Icon_with_text_button_widget_h.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class ScreenContactEdit extends StatefulWidget {
  const ScreenContactEdit({
    super.key,
    required this.contact,
    required this.color,
  });
  final ContactInfo contact;
  final Color color;

  @override
  State<ScreenContactEdit> createState() => _ScreenContactEditState();
}

class _ScreenContactEditState extends State<ScreenContactEdit> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late ContactEditScreenBloc _bloc;
  late bool isImgRemoved ;
  @override
  void initState() {
    isImgRemoved = widget.contact.image!=null?false:true;
    _bloc = context.read<ContactEditScreenBloc>();
    _firstNameController = TextEditingController(
      text: widget.contact.firstName.isEmpty ? "" : widget.contact.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.contact.lastName.isEmpty ? "" : widget.contact.lastName,
    );
    _phoneController = TextEditingController(
      text: widget.contact.phone.first.number,
    );
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            ),
            child: TextWidget(text: "Save", color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // spacing: 10,
            children: [
              SizedBox(height: 20),
              BlocBuilder<ContactEditScreenBloc, ContactEditScreenState>(
                builder: (context, state) {
                  if(state is ImagePickLoadedState && state.image!=null){
                   
                      isImgRemoved = false;
                    
                  }
                  return CircleAvatar(
                    backgroundColor:
                        (widget.contact.image == null ||isImgRemoved==true) ? widget.color : null,
                    radius: 70,
                    backgroundImage:(isImgRemoved==false)? _getBackgroundImage(state):null,
                    child:
                        (widget.contact.image == null &&
                                (state is! ImagePickLoadedState) || isImgRemoved==true)
                            ? TextWidget(
                              text: widget.contact.displayName[0].toUpperCase(),
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
      ),
    );
  }

  ImageProvider? _getBackgroundImage(ContactEditScreenState state) {
    if (state is ImagePickLoadedState && state.image != null) {
      return FileImage(File(state.image!.path));
    } else if (widget.contact.image != null) {
      return MemoryImage(widget.contact.image!);
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
