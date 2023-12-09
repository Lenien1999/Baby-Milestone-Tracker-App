class Milestone {
  final String id;
  final String title; // First smile, First tooth, etc.
  final DateTime date; // Date of the milestone
  final String notes; // Additional notes

  final String milestone;

  Milestone({
    required this.milestone,
    required this.id,
    required this.title,
    required this.date,
    required this.notes,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'notes': notes,
      'milestone':milestone
    };
  }

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      id: map['id'],
      milestone:map['milestone'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }
}

List<Milestone> milestones = [];
