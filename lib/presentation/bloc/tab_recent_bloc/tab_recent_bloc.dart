import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
part 'tab_recent_event.dart';
part 'tab_recent_state.dart';

class TabRecentBloc extends Bloc<TabRecentEvent, TabRecentState> {
  TabRecentBloc() : super(TabRecentInitial()) {
    on<ExpandedIndexChangingEvent>((event, emit) {
      emit(ExpandedIndexChangedState(expandedInde: event.expandedIndex));
    });

    on<GetCallLogsEvent>((event, emit) async {
      emit(GetCallLogsLoadingState());
      try {
         //await FlutterContacts.requestPermission();
        if (await Permission.phone.request().isGranted) {
          Iterable<CallLogEntry> entries = await CallLog.get();

          List<CallLogEntry> callLogs = entries.toList();

          List<CallLogEntry> todayCalls = [];
          List<CallLogEntry> yesterdayCalls = [];
          List<CallLogEntry> olderCalls = [];
          List<CallLogEntry> missedCalls = [];
          Map<String?, CallLogEntry> uniqueLogs = {};

          DateTime now = DateTime.now();
          DateTime todayStart = DateTime(now.year, now.month, now.day);
          DateTime yesterdayStart = todayStart.subtract(Duration(days: 1));

          for (var log in callLogs) {
            String? key = log.number;
            if (key != null && key.isNotEmpty) {
              if (!uniqueLogs.containsKey(key) ||
                  (log.timestamp ?? 0) > (uniqueLogs[key]?.timestamp ?? 0)) {
                uniqueLogs[key] = log;
                if(log.callType.toString()=="CallType.missed")missedCalls.add(log);
                DateTime callDate = DateTime.fromMillisecondsSinceEpoch(
                  log.timestamp!,
                );
                if (callDate.isAfter(todayStart)) {
                  todayCalls.add(log);
                } else if (callDate.isAfter(yesterdayStart)) {
                  yesterdayCalls.add(log);
                } else {
                  olderCalls.add(log);
                }
              }
            }
          }

          List<CallLogEntry> deduplicatedLogs = uniqueLogs.values.toList();

          emit(GetCallLogsLoadedState(logs: deduplicatedLogs,todayCalls: todayCalls,yesterdayCalls: yesterdayCalls,olderCalls: olderCalls,missedCalls: missedCalls));
        } else {
          log("Call log permission denied");
        }
      } catch (e) {
        log("somthing issue while fetching call logs $e");
      }
    });
  }
}
