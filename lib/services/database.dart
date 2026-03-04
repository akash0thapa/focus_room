import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_room/models/room_model.dart';

class DatabaseService {
  final CollectionReference roomCollection = FirebaseFirestore.instance
      .collection('Rooms');
  //to create a room with id in collections in firebase, then goto create button.
  Future createRoom(
    String topic,
    String goal,
    String description,
    int memberCount,
    DateTime endTime,
  ) async {
    DocumentReference docRef = roomCollection.doc();
    await docRef.set({
      'id': docRef.id,
      'topic': topic,
      'goal': goal,
      'description': description,
      'memberCount': memberCount,
      'endTime': Timestamp.fromDate(endTime),
    });
  }
  //same as await roomcollection.doc().set
  //but will create new id so better to use docref which refer to the document with same id

  //Now to update name in room tile, get acces to the firebase snapshots
  //this querysnapshot give all the documents of the collection
  //now create a stream to access it
  List<RoomModel> _roomListsFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RoomModel(
        id: doc.id,
        topic: doc['topic'],
        goal: doc['goal'],
        description: doc['description'],
        memberCount: doc['memberCount'],
        endTime: (doc['endTime'] as Timestamp).toDate(),
      );
    }).toList();
  }

  //here's the stream created
  //now use this in home page where tiles are to be shown
  Stream<List<RoomModel>> get roomList {
    return roomCollection.snapshots().map(_roomListsFromSnapShot);
  }

  //logic to join the room and then increment the user count
  Future joinRoom(String roomId) async {
    await roomCollection.doc(roomId).update({
      'memberCount': FieldValue.increment(1),
    });
  }

  Future leaveRoom(String roomId) async {
    await roomCollection.doc(roomId).update({
      'memberCount': FieldValue.increment(-1),
    });
  }

  //to delete room when timer is up
  Future deleteRoom(String roomId) async {
    await roomCollection.doc(roomId).delete();
  }
}
