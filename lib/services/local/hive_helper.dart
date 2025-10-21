import 'package:hive/hive.dart';
import '../../models/note.dart';

class HiveHelper {
  static const String _boxName = 'notesBox';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Note>(_boxName);
    }
  }

  Future<List<Note>> getNotes() async {
    final box = Hive.box<Note>(_boxName);
    return box.values.toList();
  }

  Future<void> addNote(Note note) async {
    final box = Hive.box<Note>(_boxName);
    await box.put(note.id, note);
  }

  Future<void> updateNote(Note note) async {
    final box = Hive.box<Note>(_boxName);
    await box.put(note.id, note);
  }

  Future<void> deleteNoteById(String id) async {
    final box = Hive.box<Note>(_boxName);
    await box.delete(id);
  }

}
