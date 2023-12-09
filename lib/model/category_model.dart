import 'milestone.dart';

class MilestoneType {
  final String? id;
  final String type; // Physical, Cognitive, Language, Health-Related
  final List<Milestone> milestones;
  final String image; // Add an image attribute to store the image path

  MilestoneType({
    this.id,
    required this.type,
    required this.milestones,
    required this.image, // Include this parameter in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'milestones': milestones.map((m) => m.toMap()).toList(),
      'image': image, // Store the image path in the map
    };
  }

  factory MilestoneType.fromMap(Map<String, dynamic> map) {
    return MilestoneType(
      id: map['id'],
      type: map['type'],
      milestones: List<Milestone>.from(
        (map['milestones'] as List<dynamic>).map((m) => Milestone.fromMap(m)),
      ),
      image: map['image'], // Retrieve the image path from the map
    );
  }
}

List<MilestoneType> milestoneTypeList = [
  MilestoneType(
      type: 'Physical',
      milestones: milestones,
      image: 'assets/images/physi.png'),
  MilestoneType(
      type: 'Health-Related',
      milestones: milestones,
      image: 'assets/images/health.png'),
  MilestoneType(
      type: 'Cognitive',
      milestones: milestones,
      image: 'assets/images/cong.png'),
  MilestoneType(
      type: 'Language', milestones: milestones, image: 'assets/images/lang.png')
];
