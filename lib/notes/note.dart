import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String notes;

  @HiveField(1)
  late bool wantReminder;

  @HiveField(2)
  late int selectedColor;

  @HiveField(3)
  late int notificationDate;

  Note(
      this.notes, this.wantReminder, this.selectedColor, this.notificationDate);
}

//flutter packages pub run build_runner build
