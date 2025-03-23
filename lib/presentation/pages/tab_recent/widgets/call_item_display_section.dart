import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/tab_recent/widgets/expanded_items.dart';
import 'package:phone/presentation/widgets/item_card_widget.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class CallItemsDisplaySection extends StatelessWidget {
  CallItemsDisplaySection({super.key});

  List<CallLogEntry> callLogs = [];

  int? todayText;

  int yesterdayText = -1;

  int olderText = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TabRecentBloc, TabRecentState>(
        builder: (context, state) {
          log("Current state: $state");
          if (state is GetCallLogsLoadedState) {
            todayText = null;
            yesterdayText = -1;
            olderText = -1;
            callLogs = state.logs;
            if (state.todayCalls.isNotEmpty) {
              todayText = 0;
            }
            if (state.yesterdayCalls.isNotEmpty) {
              if (state.todayCalls.isNotEmpty) {
                yesterdayText = state.todayCalls.length;
              } else {
                yesterdayText = 0;
              }
            }
            if (state.olderCalls.isNotEmpty) {
              if (state.yesterdayCalls.isNotEmpty) {
                olderText += state.yesterdayCalls.length + 1;
              }
              if (state.todayCalls.isNotEmpty) {
                olderText += state.todayCalls.length;
              }
            }
            log(state.todayCalls.length.toString());
            log(state.yesterdayCalls.length.toString());
            log(state.olderCalls.length.toString());
            log(state.logs.length.toString());
            log(todayText.toString());
            log(yesterdayText.toString());
            log(olderText.toString());
          }
          if (state is GetCallLogsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            );
          } else if (state is GetCallLogsLoadedState ||
              state is ExpandedIndexChangedState) {
            return ListView.separated(
              itemBuilder: (context, index) {
                var onePerson = callLogs[index];
                String personName =
                    (onePerson.name == "" || onePerson.name == null)
                        ? (onePerson.number ?? "Unknown")
                        : onePerson.name!;
                String callTime =
                    onePerson.timestamp != null
                        ? DateFormat('MMM d, h:mma').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            onePerson.timestamp!,
                          ),
                        )
                        : "No time available";
                bool isExpanded =
                    state is ExpandedIndexChangedState &&
                    state.expandedInde == index;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    if (todayText != null && index == todayText)
                      TextWidget(
                        text: "Today",
                        padding: EdgeInsets.only(left: 12),
                      ),
                    if (index == yesterdayText)
                      TextWidget(
                        text: "Yesterday",
                        padding: EdgeInsets.only(left: 12),
                      ),
                    if (index == olderText)
                      TextWidget(
                        text: "Older",
                        padding: EdgeInsets.only(left: 12),
                      ),
                    GestureDetector(
                      onTap: () {
                        context.read<TabRecentBloc>().add(
                          ExpandedIndexChangingEvent(
                            expandedIndex: isExpanded ? null : index,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          //Item card widget--------------------
                          ItemCardWidget(
                            index: index,
                            personName: personName,
                            onePerson: onePerson,
                            callTime: callTime,
                          ),
                          //Expanding row---------------------------
                          ExpandableRow(isExpanded: isExpanded),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: callLogs.length < 100 ? callLogs.length : 60,
            );
          } else {
            return SizedBox(
              child: Center(child: TextWidget(text: "Emptyy", fontSize: 30)),
            );
          }
        },
      ),
    );
  }
}
