part of 'contact_edit_screen_bloc.dart';

@immutable
sealed class ContactEditScreenEvent {}
class ImagePickEvent extends ContactEditScreenEvent{}

class ResetImageEvent extends ContactEditScreenEvent{}