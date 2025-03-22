part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}
class TabChangingEvent extends HomeScreenEvent{
  int currentTab;
  TabChangingEvent({required this.currentTab});
}
