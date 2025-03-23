part of 'tab_contacts_bloc.dart';

@immutable
sealed class TabContactsEvent {}

class FetchAllContactsEvent extends TabContactsEvent{}
