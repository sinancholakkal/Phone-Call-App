import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/tab_recent/widgets/expanded_items.dart';
import 'package:phone/presentation/widgets/icon_with_text.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class TabRecent extends StatefulWidget {
  const TabRecent({super.key});

  @override
  State<TabRecent> createState() => _TabRecentState();
}

class _TabRecentState extends State<TabRecent> {
  List<CallLogEntry> callLogs = [];

  @override
  void initState() {
    context.read<TabRecentBloc>().add(GetCallLogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoSearchTextField(padding: EdgeInsets.all(15)),
        ),
        Expanded(
          child: BlocBuilder<TabRecentBloc, TabRecentState>(
            builder: (context, state) {
              log("Current state: $state");
              if (state is GetCallLogsLoadedState) {
                callLogs = state.logs;
              }
              if (state is GetCallLogsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCallLogsLoadedState || state is ExpandedIndexChangedState) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var onePerson = callLogs[index];
                    String callTime = onePerson.timestamp != null
                        ? DateFormat('MMM d, h:mma')
                            .format(DateTime.fromMillisecondsSinceEpoch(onePerson.timestamp!))
                            
                        : "No time available";
                    bool isExpanded = state is ExpandedIndexChangedState && state.expandedInde == index;

                    return GestureDetector(
                      onTap: () {
                        context.read<TabRecentBloc>().add(
                              ExpandedIndexChangingEvent(
                                expandedIndex: isExpanded ? null : index,
                              ),
                            );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.primaries[index % Colors.primaries.length],
                              child: const Icon(Icons.person, size: 32),
                            ),
                            title: TextWidget(
                              text: (onePerson.name == "" || onePerson.name == null)
                                  ? (onePerson.number ?? "Unknown")
                                  : onePerson.name!,
                              fontSize: 17,
                            ),
                            subtitle: TextWidget(
                              text: callTime,
                              fontSize: 16,
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.phone),
                            ),
                          ),
                          ExpandableRow(isExpanded: isExpanded),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: callLogs.length, // Use stored logs length
                );
              }  else {
                return SizedBox(
                  child: Center(child: TextWidget(text: "Emptyy", fontSize: 30)),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}


class ExpandableRow extends StatefulWidget {
  final bool isExpanded;
  const ExpandableRow({required this.isExpanded});

  @override
  State<ExpandableRow> createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow> {
  bool showIcons = false;

  @override
  void didUpdateWidget(covariant ExpandableRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isExpanded && !oldWidget.isExpanded) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (mounted && widget.isExpanded) {
          setState(() {
            showIcons = true;
          });
        }
      });
    } else if (!widget.isExpanded) {
      setState(() {
        showIcons = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.isExpanded ? 100 : 0,
      child:
          showIcons
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWIthTextWidget(
                    icon: Icon(Icons.person_add_alt_outlined),
                    text: "Add contact",
                  ),
                  IconWIthTextWidget(
                    icon: Icon(Icons.message_outlined),
                    text: "Message",
                  ),
                  IconWIthTextWidget(
                    icon: Icon(Icons.history),
                    text: "History",
                  ),
                ],
              )
              : SizedBox.shrink(),
    );
  }
}