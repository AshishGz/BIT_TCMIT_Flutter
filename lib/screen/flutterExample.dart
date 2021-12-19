import 'package:bit_flutter/notes/notesHome.dart';
import 'package:bit_flutter/screen/myBottomNavigation.dart';
import 'package:bit_flutter/screen/myHomeScreen.dart';
import 'package:bit_flutter/screen/widgestFlutter.dart';
import 'package:flutter/material.dart';

class FlutterExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Class'),
      ),
      body: Column(children: [
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomeScreen()));
            },
            child: Text('API')),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FlutterWidgets()));
            },
            child: Text('Widgets Example')),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBottomNavigation()));
            },
            child: Text('MyBottomNavigation')),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotesHome()));
            },
            child: Text('NotesHome'))
      ]),
    );
  }
}
