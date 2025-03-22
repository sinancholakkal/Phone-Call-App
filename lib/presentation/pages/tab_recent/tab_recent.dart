import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/tab_recent/widgets/expanded_items.dart';
import 'package:phone/presentation/widgets/text_widget.dart';

class TabRecent extends StatelessWidget {
  TabRecent({super.key});

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
              return ListView.separated(
                itemBuilder: (context, index) {
                  bool isExpanded =
                      (state is ExpandedIndexChangedState)
                          ? state.expandedInde == index
                          : false;

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
                            radius: 30,
                            backgroundColor:
                                Colors.primaries[index %
                                    Colors.primaries.length],
                            child: Icon(Icons.person, size: 32),
                          ),
                          title: TextWidget(
                            text: "Muhammed Sinan",
                            fontSize: 20,
                          ),
                          subtitle: TextWidget(
                            text: "Fri 11:46 PM",
                            fontSize: 16,
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone),
                          ),
                        ),
                        ExpandableRow(isExpanded: isExpanded),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 20,
              );
            },
          ),
        ),
      ],
    );
  }
}



