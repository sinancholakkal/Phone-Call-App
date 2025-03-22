import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
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
        if (await Permission.phone.request().isGranted) {
          Iterable<CallLogEntry> entries = await CallLog.get();
          
          
          List<CallLogEntry> callLogs = entries.toList();
          Map<String?, CallLogEntry> uniqueLogs = {};

          for (var log in callLogs) {
            String? key = log.number;
            if (key != null && key.isNotEmpty) {
              uniqueLogs[key] = log;
            }
          }

          List<CallLogEntry> deduplicatedLogs = uniqueLogs.values.toList();
          log("Fetched ${deduplicatedLogs.length} unique call logs");
          if (deduplicatedLogs.isNotEmpty) {
            log(deduplicatedLogs[0].number.toString());
          }
          if (deduplicatedLogs.length > 1) {
            log(deduplicatedLogs[1].number.toString());
          }
          if (deduplicatedLogs.length > 2) {
            log(deduplicatedLogs[2].number.toString());
          }
          log("==========www");

          emit(GetCallLogsLoadedState(logs: deduplicatedLogs));
        } else {
          log("Call log permission denied");
        }
      } catch (e) {
        log("somthing issue while fetching call logs $e");
      }
    });
  }
}
