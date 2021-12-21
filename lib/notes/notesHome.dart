import 'package:bit_flutter/notes/hiveManger.dart';
import 'package:bit_flutter/notes/manageNotes.dart';
import 'package:bit_flutter/notes/myNoteCard.dart';
import 'package:bit_flutter/notes/note.dart';
import 'package:flutter/material.dart';

class NotesHome extends StatefulWidget {
  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  List notes = <Note>[];

  getNotes() async {
    notes = await HiveManger.onGetNotes();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getNotes();
    super.initState();
  }

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
        body: ListView(children: [
          ...notes.map((e) => MyNote(e))
        ]));
  }
}
