import 'package:bit_flutter/notes/manageNotes.dart';
import 'package:bit_flutter/notes/myNoteCard.dart';
import 'package:flutter/material.dart';

class NotesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Notes'),
        ),
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green,
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ManageNotes();
                  });
            },
          ),
        ),
        body: ListView(
          children: [
            MyNote(),
            MyNote(),
            MyNote(),
            MyNote(),
            MyNote(),
          ],
        ));
  }
}
