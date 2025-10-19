import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  const Note({
    required this.id,
    required this.title,
    required this.body,
  });

  Note copyWith({String? id, String? title, String? body}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [id, title, body];
}
