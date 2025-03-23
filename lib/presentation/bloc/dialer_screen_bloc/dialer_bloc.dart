import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone_state/phone_state.dart';

part 'dialer_event.dart';
part 'dialer_state.dart';

class DialerBloc extends Bloc<DialerEvent, DialerState> {
  DialerBloc() : super(DialerInitial()) {
    on<MakeCallEvent>((event, emit) async {
      // Store the context for later use
      final BuildContext callContext = event.context;
      await makeDirectCall(event.phone, callContext);
      // Listen for call end and refresh TabRecentBloc
      PhoneState.stream.listen((state) {
        if (state == PhoneStateStatus.CALL_ENDED) {
          log("Call ended, refreshing call logs");
          callContext.read<TabRecentBloc>().add(GetCallLogsEvent());
        }
      });
    });
  }

  Future<void> makeDirectCall(String number, BuildContext context) async {
    if (await Permission.phone.isGranted) {
      final DirectCaller directCaller = DirectCaller();
      bool? success = await directCaller.makePhoneCall(number);
      if (success == true) {
        log('Call initiated successfully');
      } else {
        log('Failed to initiate call');
      }
    } else {
      PermissionStatus status = await Permission.phone.request();
      if (status.isGranted) {
        final DirectCaller directCaller = DirectCaller();
        bool? success = await directCaller.makePhoneCall(number);
        if (success == true) {
          log('Call initiated successfully');
        } else {
          log('Failed to initiate call');
        }
      } else if (status.isDenied) {
        log('Permission denied by user');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please grant phone permission to make calls')),
        );
      } else if (status.isPermanentlyDenied) {
        log('Permission permanently denied');
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
}