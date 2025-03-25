part of 'contact_edit_screen_bloc.dart';

@immutable
sealed class ContactEditScreenState {}

final class ContactEditScreenInitial extends ContactEditScreenState {}
class ImagePickLoadedState extends ContactEditScreenState{
  final XFile? image;
  ImagePickLoadedState({required this.image});
}
class ImageInitialState extends ContactEditScreenState{}