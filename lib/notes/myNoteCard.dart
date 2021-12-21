import 'package:bit_flutter/notes/note.dart';
import 'package:flutter/material.dart';

class MyNote extends StatelessWidget {
  Note note;

  MyNote(this.note);

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
                        '19 Dec, 2021 9:15 am',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            )
          ],
        ));
  }
}
