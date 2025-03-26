part of 'contact_edit_screen_bloc.dart';

@immutable
sealed class ContactEditScreenState {}

final class ContactEditScreenInitial extends ContactEditScreenState {}
class ImagePickLoadedState extends ContactEditScreenState{
  final Uint8List? imageByte;
  ImagePickLoadedState({required this.imageByte});
}
class ImageInitialState extends ContactEditScreenState{}
class ContactEditLoadedState extends ContactEditScreenState{}