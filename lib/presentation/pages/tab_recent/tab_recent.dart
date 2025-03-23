import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/tab_recent/widgets/call_item_display_section.dart';
import 'package:phone/presentation/pages/tab_recent/widgets/search_section.dart';

class TabRecent extends StatefulWidget {
  const TabRecent({super.key});
  @override
  State<TabRecent> createState() => _TabRecentState();
}
class _TabRecentState extends State<TabRecent> {
  @override
  void initState() {
    context.read<TabRecentBloc>().add(GetCallLogsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SearchSection----------
        SearchSection(),
        //Call items section----------------
        CallItemsDisplaySection(),
      ],
    );
  }
}