const String tableNotes = 'notes';

class NoteField{
  static const String id = 'id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note{
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createTime;

  Note({
  this.id,
  required this.isImportant,
  required this.number,
  required this.title,
  required this.description,
  required this.createTime,
  });

  Note copy({
   int? id,
   bool? isImportant,
   int? number,
   String? title,
   String? description,
   DateTime? createTime,
  }) {
    return Note(
      id:id,
      isImportant: isImportant ?? this.isImportant, 
      number: number ?? this.number, 
      title: title ?? this.title, 
      description: description ?? this.description, 
      createTime: createTime ?? this.createTime);
  }
  static Note fromJson(Map<String, Object?> json){  
    return Note(
    id: json[NoteField.id] as int?,
    isImportant: json[NoteField.isImportant] == 1,
    number: json[NoteField.number]as int, 
    title: json[NoteField.title]as String, 
    description: json[NoteField.description]as String,  
    createTime: DateTime.parse(json[NoteField.time] as String));
  }

  Map<String, Object?> toJson() => {
    NoteField.id:id,
    NoteField.isImportant: isImportant,
    NoteField.number: number,
    NoteField.title: title,
    NoteField.description: description,

    NoteField.time: createTime.toIso8601String(),
  };
}
