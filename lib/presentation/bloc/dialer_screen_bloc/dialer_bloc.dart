import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dialer_event.dart';
part 'dialer_state.dart';

class DialerBloc extends Bloc<DialerEvent, DialerState> {
  DialerBloc() : super(DialerInitial()) {
    on<DialerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
