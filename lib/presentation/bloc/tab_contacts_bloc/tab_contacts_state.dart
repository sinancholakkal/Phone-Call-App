part of 'tab_contacts_bloc.dart';

@immutable
sealed class TabContactsState {}

final class TabContactsInitial extends TabContactsState {}
class FetchAllContactsLoadingState extends TabContactsState{}
class FetchAllContactsLoadedState extends TabContactsState{
  final List<Contact>contacts;
  FetchAllContactsLoadedState({required this.contacts});
}
