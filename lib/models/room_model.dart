class RoomModel {
  final String id;
  final String name;
  final String topic;
  final String description;
  final int memberCount;
  // final DateTime endTime;   

  RoomModel({
    required this.id,
    required this.name,
    required this.topic,
    required this.description,
    required this.memberCount,
    // required this.endTime,
  });
}