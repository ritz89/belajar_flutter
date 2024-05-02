class Diary {
  final int id;
  final DateTime date;
  final String label;

  Diary({
    required this.id,
    required this.date,
    required this.label,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'],
      date: DateTime.parse(json['date']),
      label: json['label'],
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
