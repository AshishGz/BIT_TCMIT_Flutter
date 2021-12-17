import 'package:bit_flutter/screen/flutterExample.dart';
import 'package:bit_flutter/screen/myHomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xff000000),
        dividerColor: Colors.grey,
        brightness: Brightness.dark,
        primaryColor: Colors.black54,
        accentColor: Color(0xffed1c23),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterExample(),
    );
  }
}
