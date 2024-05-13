import 'package:belajar_flutter/models/diary_entry.dart';

class Diary {
  final int id;
  final DateTime date;
  final String label;
  List<DiaryEntry> entries;

  Diary({
    required this.id,
    required this.date,
    required this.label,
    this.entries = const [],
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    print(json);
    return Diary(
      id: json['id'] ?? 0, // Provide a default value if json['id'] is null
      date: DateTime.parse(json['date']),
      label: json['label'],
      entries: (json['diaryentry_set'] as List<dynamic>?)
              ?.map((e) => DiaryEntry.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'label': label,
    };
  }
}
