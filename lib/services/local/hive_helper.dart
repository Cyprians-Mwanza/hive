import 'package:hive/hive.dart';
import '../../models/note.dart';

class HiveHelper {
  static const String _boxName = 'notesBox';

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<Note>(_boxName);
    }
  }

  Future<void> addNote(Note note) async {
    final box = Hive.box<Note>(_boxName);
    await box.put(note.id, note);
  }

  Future<List<Note>> getNotes() async {
    final box = Hive.box<Note>(_boxName);
    return box.values.toList();
  }

  Future<Note?> getNoteById(String id) async {
    final box = Hive.box<Note>(_boxName);
    return box.get(id);
  }

  Future<void> updateNote(Note note) async {
    final box = Hive.box<Note>(_boxName);
    await box.put(note.id, note);
  }

  Future<void> deleteNoteById(String id) async {
    final box = Hive.box<Note>(_boxName);
    await box.delete(id);
  }

  Future<void> deleteAllNotes() async {
    final box = Hive.box<Note>(_boxName);
    await box.clear();
  }

  Future<void> closeBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box<Note>(_boxName).close();
    }
  }
}
