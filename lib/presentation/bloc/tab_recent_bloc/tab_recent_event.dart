part of 'tab_recent_bloc.dart';

@immutable
sealed class TabRecentEvent {}
class ExpandedIndexChangingEvent extends TabRecentEvent{
  int? expandedIndex;
  ExpandedIndexChangingEvent({required this.expandedIndex});
}