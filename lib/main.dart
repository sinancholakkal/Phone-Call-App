import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:phone/presentation/bloc/contact_edit_screen_bloc/contact_edit_screen_bloc.dart';
import 'package:phone/presentation/bloc/dialer_screen_bloc/dialer_bloc.dart';
import 'package:phone/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:phone/presentation/bloc/tab_contacts_bloc/tab_contacts_bloc.dart';
import 'package:phone/presentation/bloc/tab_recent_bloc/tab_recent_bloc.dart';
import 'package:phone/presentation/pages/screen_home/screen_home.dart';
import 'package:phone/presentation/pages/tab_recent/tab_recent.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenBloc()),
        BlocProvider(create: (context) => TabRecentBloc()),
        BlocProvider(create: (context)=> DialerBloc()),
        BlocProvider(create: (context)=> TabContactsBloc()),
        BlocProvider(create: (context)=> ContactEditScreenBloc()),
      ],
      
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
        // Customize dark theme properties
        scaffoldBackgroundColor: Colors.black, // Background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900], // Dark app bar
          foregroundColor: Colors.white, // Text/icons on app bar
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white, // Selected tab text
          unselectedLabelColor: Colors.grey[400], // Unselected tab text
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
        )
     
      ),
      home: ScreenHome(),)
    );
  }
}