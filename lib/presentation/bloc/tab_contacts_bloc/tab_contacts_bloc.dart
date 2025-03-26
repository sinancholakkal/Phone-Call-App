import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';

part 'tab_contacts_event.dart';
part 'tab_contacts_state.dart';

class TabContactsBloc extends Bloc<TabContactsEvent, TabContactsState> {
  TabContactsBloc() : super(TabContactsInitial()) {
    on<FetchAllContactsEvent>((event, emit) async{
     emit(FetchAllContactsLoadingState());
     try{
       if (await FlutterContacts.requestPermission()) {
      log("Contact permition granted");
      List<Contact> contacts = await FlutterContacts.getContacts(
      withProperties: true, withPhoto: true);
      emit(FetchAllContactsLoadedState(contacts: contacts));
      
    }else{
      log("Contact permition not granted");
    }
     }catch(e){
      log("Somthing wrong while fetching all contacts $e");
     }
    });

    on<FecthOneContactEvent>((event, emit)async {
      try{
        Contact? contact = await FlutterContacts.getContact(event.contactId,withAccounts: true,withPhoto: true,withProperties: true,withThumbnail: true,deduplicateProperties: true,withGroups: true);
              emit(FetchOneContactLoaded(contact: contact!));
      }catch(e){
        log("Somthing issue while fetching one contact");
      }
    },);
  }
}
