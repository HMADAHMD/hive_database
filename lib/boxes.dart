import 'package:hive/hive.dart';
import 'package:hive_tutorial/Notes.dart';

class Boxes {
  static Box<Notes> getdata() => Hive.box<Notes>('notes');
}
