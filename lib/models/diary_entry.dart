class DiaryEntry {
  final int id;
  final String name;
  final int calorie;
  final DateTime createdAt;
  final bool isBurningCalorie;

  DiaryEntry(
      {required this.id,
      required this.name,
      required this.calorie,
      required this.createdAt,
      required this.isBurningCalorie});

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      name: json['name'],
      calorie: json['calorie'],
      createdAt: DateTime.parse(json['created_at']),
      isBurningCalorie: json['is_burning_calorie'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'calorie': calorie,
      'created_at': createdAt.toIso8601String(),
      'is_burning_calorie': isBurningCalorie
    };
  }
}
