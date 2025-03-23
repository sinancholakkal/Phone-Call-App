import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone/presentation/bloc/dialer_screen_bloc/dialer_bloc.dart';
import 'package:phone/presentation/pages/screen_dialpad/widget/dialer_widget.dart';

class ScreenDialpad extends StatelessWidget {
  const ScreenDialpad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialPad(
              enableDtmf: false,
              //outputMask: "(000) 000-0000",
              hideSubtitle: false,
              backspaceButtonIconColor: Colors.red,
              buttonTextColor: Colors.white,
              dialOutputTextColor: Colors.white,
              keyPressed: (value) {
                log('$value was pressed');
              },
              makeCall: (number) {
                log(number);
                context.read<DialerBloc>().add(MakeCallEvent(phone: number, context: context));
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
