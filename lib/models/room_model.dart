class RoomModel {
  final String id;
  final String topic;
  final String goal;
  final String description;
  final int memberCount;
  final DateTime endTime;

  RoomModel({
    required this.id,
    required this.topic,
    required this.goal,
    required this.description,
    required this.memberCount,
    required this.endTime,
  });
}
