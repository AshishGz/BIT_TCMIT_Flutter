import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Details'),
        ),
        body: Container(
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text('back')),
        ));
  }
}
