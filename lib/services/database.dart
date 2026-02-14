import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_room/models/room_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    required this.uid,
  });

  final CollectionReference roomCollection=FirebaseFirestore.instance.collection('Rooms');
  //to create a room with id in collections in firebase, then goto create button.
  Future createRoom(String id, String name, String topic,String description)async{
    DocumentReference docRef=roomCollection.doc();
    await docRef.set({
      'id':docRef.id,
      'name': name,
      'topic': topic,
      'description': description, 
    });
 //same as await roomcollection.doc().set
 //but will create new id so better to use docref which refer to the document with same id
  
  }
  //Now to update name in room tile, get acces to the firebase snapshots
  //this querysnapshot give all the documents of the collection
  //now create a stream to access it
  List<RoomModel>_roomListsFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return RoomModel( 
        id: doc.id,
        name: doc['name'], 
        topic: doc['topic'], 
        description: doc['description']
        );
    }).toList();
  }
  //here's the stream created
  //now use this in home page where tiles are to be shown
  Stream<List<RoomModel>>get roomList{
    return roomCollection.snapshots().map(_roomListsFromSnapShot);
  }
  


}