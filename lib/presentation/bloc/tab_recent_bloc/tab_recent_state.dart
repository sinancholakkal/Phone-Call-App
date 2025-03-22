part of 'tab_recent_bloc.dart';

@immutable
sealed class TabRecentState {}

final class TabRecentInitial extends TabRecentState {}
class ExpandedIndexChangedState extends TabRecentState{
  int? expandedInde;
  ExpandedIndexChangedState({required this.expandedInde});
}