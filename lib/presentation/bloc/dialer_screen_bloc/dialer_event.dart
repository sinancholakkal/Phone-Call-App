part of 'dialer_bloc.dart';

@immutable
sealed class DialerEvent {}
class MakeCallEvent extends DialerEvent{
  final String phone;
  final BuildContext context;
  MakeCallEvent({required this.phone,required this.context});
}