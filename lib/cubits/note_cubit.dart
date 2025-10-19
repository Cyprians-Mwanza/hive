import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/note.dart';
import '../../services/local/hive_helper.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final HiveHelper _hiveHelper = HiveHelper();
  final _uuid = const Uuid();

  NoteCubit() : super(NoteInitial());

  Future<void> fetchAllNotes() async {
    emit(NoteLoading());
    try {
      await _hiveHelper.init();
      final notes = await _hiveHelper.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _hiveHelper.init();
      final newNote = note.copyWith(id: _uuid.v4());
      await _hiveHelper.addNote(newNote);
      emit(NoteActionSuccess('Note added.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to add note: $e'));
    }
  }

  Future<void> updateNoteById(Note note) async {
    try {
      await _hiveHelper.init();
      await _hiveHelper.updateNote(note);
      emit(NoteActionSuccess('Note updated.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to update note: $e'));
    }
  }

  Future<void> deleteNoteById(String id) async {
    try {
      await _hiveHelper.init();
      await _hiveHelper.deleteNoteById(id);
      emit(NoteActionSuccess('Note deleted.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to delete note: $e'));
    }
  }
}
