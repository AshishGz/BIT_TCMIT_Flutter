import 'package:bit_flutter/notes/color.dart';
import 'package:bit_flutter/notes/global.dart';
import 'package:bit_flutter/notes/hiveManger.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

import 'note.dart';

class ManageNotes extends StatefulWidget {
  late Note note;
  NOTES_MANAGE_MOD notes_manage_mod = NOTES_MANAGE_MOD.ADD;

  ManageNotes({required this.note, required this.notes_manage_mod});

  @override
  State<ManageNotes> createState() => _ManageNotesState();
}

class _ManageNotesState extends State<ManageNotes> {
  TextEditingController textEditingController = TextEditingController();
  int selectedColor = LIST_OF_COLORS[0];
  bool wantReminder = true;
  NepaliDateTime? _selectedDateTime = NepaliDateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = widget.note.notes;
    selectedColor = widget.note.selectedColor;
    _selectedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.notificationDate)
            .toNepaliDateTime();
    wantReminder = widget.note.wantReminder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(selectedColor),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: textEditingController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(selectedColor),
                      border: InputBorder.none,
                      labelText: 'Enter Notes',
                      hintText: 'Enter Your Notes'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Color',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...LIST_OF_COLORS.map((e) => InkWell(
                            onTap: () {
                              selectedColor = e;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 40,
                              width: 40,
                              child: selectedColor == e
                                  ? Icon(Icons.check)
                                  : SizedBox.shrink(),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(e),
                                  border: Border.all(color: Colors.grey)),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    wantReminder = !wantReminder;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      wantReminder
                          ? Icon(Icons.check_circle)
                          : Icon(Icons.check_circle_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Do you  want reminder?',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () async {
                      _selectedDateTime = await showMaterialDatePicker(
                        context: context,
                        initialDate: _selectedDateTime ?? NepaliDateTime.now(),
                        firstDate: NepaliDateTime(1970, 2, 5),
                        lastDate: NepaliDateTime(2099, 11, 6),
                        initialDatePickerMode: DatePickerMode.day,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(
                          width: 12,
                        ),
                        Text('Pick Date',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (widget.notes_manage_mod == NOTES_MANAGE_MOD.ADD) {
                            await HiveManger.onAddNotes(
                                notes: textEditingController.text,
                                selectedColor: selectedColor,
                                notification: wantReminder,
                                date:
                                    _selectedDateTime!.millisecondsSinceEpoch);
                          } else {
                            widget.note.wantReminder = wantReminder;
                            widget.note.notificationDate =
                                _selectedDateTime!.millisecondsSinceEpoch;
                            widget.note.notes = textEditingController.text;
                            widget.note.selectedColor = selectedColor;

                            await HiveManger.onUpdateNotes(widget.note);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('ADD NOTES')))
              ],
            )),
          ),
        ],
      ),
    );
  }
}
