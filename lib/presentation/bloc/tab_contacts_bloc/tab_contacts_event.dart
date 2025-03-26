part of 'tab_contacts_bloc.dart';

@immutable
sealed class TabContactsEvent {}

class FetchAllContactsEvent extends TabContactsEvent{}
class FecthOneContactEvent extends TabContactsEvent{
  final String contactId;
  FecthOneContactEvent({required this.contactId});
}