import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/presentation/pages/screen_dialpad/widget/dialer_widget.dart';
class ScreenDialpad extends StatelessWidget {
  const ScreenDialpad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
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
                    keyPressed: (value){
                      log('$value was pressed');
                    },
                    makeCall: (number){
                      log(number);
                    }
          ),
          SizedBox(height: 10,)
        ],
      )),
    );
  }
}