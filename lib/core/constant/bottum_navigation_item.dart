import 'package:flutter/material.dart';
import 'package:phone/presentation/pages/tab_contacts/tab_contacts.dart';
import 'package:phone/presentation/pages/tab_recent/tab_recent.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

List<SalomonBottomBarItem> bottumTab = [
  SalomonBottomBarItem(
    icon: Icon(Icons.access_time),
    title: Text("Recent"),
    selectedColor: const Color.fromARGB(255, 237, 133, 255),
  ),

  /// Likes
  SalomonBottomBarItem(
    icon: Icon(Icons.star_border),
    title: Text("Favorites"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: Icon(Icons.add),
    title: Text("Add"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: Icon(Icons.person),
    title: Text("Contacts"),
    selectedColor: const Color.fromARGB(255, 5, 212, 191),
  ),
];

final List<Widget> tabPages = [
    TabRecent(),
    Center(child: Text("Favorites", style: TextStyle(fontSize: 20))),
    Center(child: Text("Add New Contact", style: TextStyle(fontSize: 20))),
    TabContacts(),
  ];
