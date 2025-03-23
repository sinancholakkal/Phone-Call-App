import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';

part 'dialer_event.dart';
part 'dialer_state.dart';

class DialerBloc extends Bloc<DialerEvent, DialerState> {
  DialerBloc() : super(DialerInitial()) {
    on<MakeCallEvent>((event, emit) async{
    await makeDirectCall(event.phone,event.context);
    log("Refreshed===================");
    });
  }
}
Future<void> makeDirectCall(String number,BuildContext context) async {
    // Check if permission is granted
    if (await Permission.phone.isGranted) {
      final DirectCaller directCaller = DirectCaller();
      bool? success = await directCaller.makePhoneCall(number,); // simSlot is optional
      if (success == true) {
        log('Call initiated successfully');
      } else {
        log('Failed to initiate call');
      }
    } 
    // Request permission if not granted
    else {
      PermissionStatus status = await Permission.phone.request();
      if (status.isGranted) {
        // Permission granted, try the call again
        final DirectCaller directCaller = DirectCaller();
        await directCaller.makePhoneCall(number);
      } else if (status.isDenied) {
        print('Permission denied by user');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please grant phone permission to make calls')),
        );
      } else if (status.isPermanentlyDenied) {
        print('Permission permanently denied');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Phone permission denied. Please enable it in settings.'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    }
  }
