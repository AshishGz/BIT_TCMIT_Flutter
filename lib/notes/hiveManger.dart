import 'package:bit_flutter/notes/note.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const NOTES = '_notes';

class HiveManger {
  static initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    return true;
  }

  static onAddNotes(
      {required String notes,
      required int selectedColor,
      required bool notification,
      required int date}) async {
    try {
      await Hive.openBox<Note>(NOTES);
      Box<Note> addNote = Hive.box<Note>(NOTES);
      await addNote.add(Note(notes, notification, selectedColor, date));
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
      print('Succesfully added');
      return true;
    }
  }

  static onGetNotes() async {
    try {
      final box = await Hive.openBox<Note>(NOTES);
      List note = <Note>[];
      note = box.values.toList();
      return note;
    } catch (e) {
      print(e);
    } finally {
      Hive.close();
    }
  }
}
