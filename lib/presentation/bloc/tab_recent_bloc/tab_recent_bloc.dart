import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_recent_event.dart';
part 'tab_recent_state.dart';

class TabRecentBloc extends Bloc<TabRecentEvent, TabRecentState> {
  TabRecentBloc() : super(TabRecentInitial()) {
    on<ExpandedIndexChangingEvent>((event, emit) {
      emit(ExpandedIndexChangedState(expandedInde: event.expandedIndex));
    });
  }
}
