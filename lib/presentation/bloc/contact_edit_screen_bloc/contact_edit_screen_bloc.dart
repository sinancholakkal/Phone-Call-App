import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'contact_edit_screen_event.dart';
part 'contact_edit_screen_state.dart';

class ContactEditScreenBloc
    extends Bloc<ContactEditScreenEvent, ContactEditScreenState> {
  ContactEditScreenBloc() : super(ContactEditScreenInitial()) {
    on<ImagePickEvent>((event, emit) async {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
       Uint8List? imageByte;
      if(image!=null){
        imageByte = await File(image.path).readAsBytes();
      }
      emit(ImagePickLoadedState(imageByte: imageByte));
    });
    on<ResetImageEvent>((event, emit) {
      emit(ImageInitialState());
    });
     on<ContactEditEvent>((event, emit) {
      try{
        if(event.firstName!=null && event.contact.name.first!=event.firstName){
          event.contact.name.first = event.firstName!;
        }
         if(event.lastName!=null && event.contact.name.last!=event.lastName){
          event.contact.name.last = event.lastName!;
        }
         if(event.imageByte!=null && event.contact.photo!=event.imageByte){
          event.contact.photo = event.imageByte!;
        }
        event.contact.update();
        emit(ContactEditLoadedState());
      }catch(e){
        log("Something wrong while update contact $e");
      }
    });
  }
}
