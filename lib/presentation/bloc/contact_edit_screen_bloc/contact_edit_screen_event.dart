part of 'contact_edit_screen_bloc.dart';

@immutable
sealed class ContactEditScreenEvent {}
class ImagePickEvent extends ContactEditScreenEvent{}

class ResetImageEvent extends ContactEditScreenEvent{}

class ContactEditEvent extends ContactEditScreenEvent{
  final String? firstName;
  final String? lastName;
  final Uint8List? imageByte;
  final Contact contact;
  ContactEditEvent({required this.firstName, required this.lastName, required this.imageByte,required this.contact});
  
}