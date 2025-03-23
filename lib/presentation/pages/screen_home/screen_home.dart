  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
  import 'package:phone/core/constant/bottum_navigation_item.dart';
  import 'package:phone/core/theme/colors.dart';
  import 'package:phone/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:phone/presentation/pages/screen_dialpad/screen_dialpad.dart';
  import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

  class ScreenHome extends StatefulWidget {
    const ScreenHome({super.key});

    @override
    State<ScreenHome> createState() => _ScreenHomeState();
  }

  class _ScreenHomeState extends State<ScreenHome> {
    @override
    Widget build(BuildContext context) {
      return bloc.BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          int currentTab = 0;

          if (state is TabChangedState) {
            currentTab = state.currentTab;
          }
          return Scaffold(
            extendBody: true,
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: SalomonBottomBar(
                
              
                backgroundColor: tabBackground,
                margin: EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 20),
                onTap: (i) {
                  context.read<HomeScreenBloc>().add(
                    TabChangingEvent(currentTab: i),
                  );
                },
                currentIndex: currentTab,
                items: bottumTab,
              ),
            ),
            body: SafeArea(bottom: false,child: tabPages[currentTab],),
            floatingActionButton: FloatingActionButton(onPressed: (){
              Get.to(()=>ScreenDialpad(),transition: Transition.downToUp);
            },child: Icon(Icons.dialpad),),
          );
        },
      );
    }
  }
