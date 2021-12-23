import 'package:bit_flutter/notes/global.dart';
import 'package:bit_flutter/notes/manageNotes.dart';
import 'package:bit_flutter/notes/note.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class MyNote extends StatelessWidget {
  Note note;
  Function onGetNote;

  MyNote(this.note, this.onGetNote);

  getIconByTime(int noteDate, BuildContext context) {
    int todayDate = DateTime.now().millisecondsSinceEpoch;
    if (todayDate > noteDate) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
    } else {
      return InkWell(
        onTap: () => {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ManageNotes(
                  note: note,
                  notes_manage_mod: NOTES_MANAGE_MOD.EDIT,
                );
              }).then((value) => onGetNote())
        },
        child: Icon(
          Icons.edit,
          color: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(note.selectedColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.notes,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.green,
                      ),
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                note.notificationDate)
                            .toNepaliDateTime()
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            getIconByTime(note.notificationDate, context)
          ],
        ));
  }
}
