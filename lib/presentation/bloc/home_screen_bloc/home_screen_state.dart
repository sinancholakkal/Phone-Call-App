part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}
class TabChangedState extends HomeScreenState{
  int currentTab;
  TabChangedState({required this.currentTab});
}
